(define (root-count n edges guesses k)
  (define adj (make-vector n '()))
  (for ([edge edges])
    (let ([u (vector-ref edge 0)] [v (vector-ref edge 1)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v)))))

  (define guess-set (set))
  (for ([guess guesses])
    (set-add! guess-set (list (vector-ref guess 0) (vector-ref guess 1))))

  (define (count-correct u p)
    (let loop ([neighbors (vector-ref adj u)] [count 0])
      (cond
        [(null? neighbors) count]
        [else
         (let ([v (car neighbors)])
           (if (= v p)
               (loop (cdr neighbors) count)
               (let ([new-count (count-correct v u)])
                 (loop (cdr neighbors) (+ count new-count (if (set-member? guess-set (list u v)) 1 0))))))])))

  (define init-count (count-correct 0 -1))

  (define (dfs u p correct-count)
    (let loop ([neighbors (vector-ref adj u)] [count 0])
      (cond
        [(null? neighbors) count]
        [else
         (let ([v (car neighbors)])
           (if (= v p)
               (loop (cdr neighbors) count)
               (let ([new-correct-count
                      (if (set-member? guess-set (list u v))
                          (- correct-count 1)
                          (+ correct-count 1))])
                 (loop (cdr neighbors) (+ count (if (>= new-correct-count k) 1 0) (dfs v u new-correct-count))))))])))

  (+ (if (>= init-count k) 1 0) (dfs 0 -1 init-count)))