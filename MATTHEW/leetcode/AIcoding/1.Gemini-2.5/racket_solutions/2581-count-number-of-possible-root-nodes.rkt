#lang racket

(define (count-number-of-possible-root-nodes n edges guesses k)
  (define adj (make-vector n '()))
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (vector-set! adj u (cons v (vector-ref adj u)))
              (vector-set! adj v (cons u (vector-ref adj v))))
            edges)

  (define guess-set (make-hash))
  (for-each (lambda (guess)
              (hash-set! guess-set (list (car guess) (cadr guess)) #t))
            guesses)

  (define subtree-correct-u-as-parent (make-vector n 0))

  (define (dfs1 u p)
    (define current-subtree-correct 0)
    (for-each (lambda (v)
                (when (not (= v p))
                  (set! current-subtree-correct (+ current-subtree-correct (dfs1 v u)))
                  (when (hash-has-key? guess-set (list u v))
                    (set! current-subtree-correct (+ current-subtree-correct 1)))))
              (vector-ref adj u))
    (vector-set! subtree-correct-u-as-parent u current-subtree-correct)
    current-subtree-correct)

  (define initial-correct-guesses (dfs1 0 -1))

  (define dp (make-vector n 0))
  (vector-set! dp 0 initial-correct-guesses)

  (define ans 0)

  (define (dfs2 u p)
    (when (>= (vector-ref dp u) k)
      (set! ans (+ ans 1)))

    (for-each (lambda (v)
                (when (not (= v p))
                  (define next-dp-val (vector-ref dp u))
                  (when (hash-has-key? guess-set (list u v))
                    (set! next-dp-val (- next-dp-val 1)))
                  (when (hash-has-key? guess-set (list v u))
                    (set! next-dp-val (+ next-dp-val 1)))

                  (vector-set! dp v next-dp-val)
                  (dfs2 v u)))
              (vector-ref adj u))
    )

  (dfs2 0 -1)
  ans)