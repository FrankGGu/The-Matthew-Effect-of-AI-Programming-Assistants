(require racket/hash)
(require racket/list)

(define (longest-square-streak nums)
  (define sorted-nums (sort nums <))
  (define dp (make-hash)) ; Stores (number . streak-length)
  (define max-streak 0)

  (for ([n sorted-nums])
    (define sqrt-n-flonum (sqrt n))
    (define current-streak 1)

    (when (integer? sqrt-n-flonum)
      (define int-sqrt-n (inexact->exact sqrt-n-flonum))
      (when (hash-has-key? dp int-sqrt-n)
        (set! current-streak (+ 1 (hash-ref dp int-sqrt-n)))))

    (hash-set! dp n current-streak)
    (set! max-streak (max max-streak current-streak)))

  (if (>= max-streak 2)
      max-streak
      -1))