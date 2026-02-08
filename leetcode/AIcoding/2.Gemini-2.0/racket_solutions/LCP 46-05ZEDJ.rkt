(define (volunteer-deployment finalCnt volInfo)
  (define n (vector-length volInfo))
  (define adj (make-vector n '()))
  (define degree (make-vector n 0))
  (define total-vol 0)

  (for/list ([i (in-range n)])
    (define u (vector-ref volInfo i))
    (set! total-vol (+ total-vol (car u)))
    (for ([j (in-list (cdr u))])
      (vector-set! adj i (cons (- j 1) (vector-ref adj i)))
      (vector-set! degree i (+ (vector-ref degree i) 1))))

  (define (calc-sum x)
    (let loop ([i 0] [sum 0])
      (if (= i n)
          sum
          (loop (+ i 1) (+ sum (* (expt 2 (vector-ref degree i)) x))))))

  (define (find-x)
    (define (check x)
      (<= (calc-sum x) finalCnt))

    (define (binary-search low high)
      (if (> (- high low) 1e-5)
          (let ([mid (/ (+ low high) 2)])
            (if (check mid)
                (binary-search mid high)
                (binary-search low mid)))
          low))

    (binary-search 0 (max 1 (/ finalCnt n))))

  (define x (find-x))

  (define result (make-vector n 0))
  (for/list ([i (in-range n)])
    (vector-set! result i (inexact->exact (round (+ (car (vector-ref volInfo i)) (* (expt 2 (vector-ref degree i)) x)))))
  )

  (list->vector result)
)