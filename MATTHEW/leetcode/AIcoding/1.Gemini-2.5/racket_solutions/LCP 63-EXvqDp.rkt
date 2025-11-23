#lang racket

(require racket/set)

(define MAX-NUM 100001)
(define spf (make-vector MAX-NUM))

(for ([i (in-range MAX-NUM)])
  (vector-set! spf i i))

(for ([p (in-range 2 (isqrt (- MAX-NUM 1)))])
  (when (= (vector-ref spf p) p)
    (for ([i (in-range (* p p) MAX-NUM p)])
      (when (= (vector-ref spf i) i)
        (vector-set! spf i p)))))

(define (get-distinct-prime-factors n)
  (define factors (set))
  (let loop ([num n])
    (when (> num 1)
      (define p (vector-ref spf num))
      (set! factors (set-add factors p))
      (loop (/ num p))))
  factors)

(define (maximum-prime-factor-score n edges nums)
  (define adj (make-vector n (list)))
  (for ([edge edges])
    (define u (car edge))
    (define v (cadr edge))
    (define u-idx (- u 1))
    (define v-idx (- v 1))
    (vector-set! adj u-idx (cons v-idx (vector-ref adj u-idx)))
    (vector-set! adj v-idx (cons u-idx (vector-ref adj v-idx))))

  (define node-prime-factors (make-vector n))
  (for ([i (in-range n)])
    (vector-set! node-prime-factors i (get-distinct-prime-factors (list-ref nums i))))

  (define max-score (box 0))

  (define (dfs u parent current-path-factors-from-parent)
    (define current-path-factors-to-u current-path-factors-from-parent)
    (define u-factors (vector-ref node-prime-factors u))

    (for ([p (in-set u-factors)])
      (set! current-path-factors-to-u (set-add current-path-factors-to-u p)))

    (set-box! max-score (max (unbox max-score) (set-count current-path-factors-to-u)))

    (for ([v (vector-ref adj u)])
      (unless (= v parent)
        (dfs v u current-path-factors-to-u))))

  (dfs 0 -1 (set))

  (unbox max-score))