(define (good-days-to-rob-bank security time)
  (define n (length security))
  (define good-days '())
  (define count 0)

  (for ((i (in-range 1 n)))
    (if (<= (list-ref security (- i 1)) (list-ref security i))
        (set! count (+ count 1))
        (set! count 0))

    (if (>= count time)
        (if (>= (- i time) 0)
            (set! good-days (cons (- i time) good-days)))))

  (reverse good-days))