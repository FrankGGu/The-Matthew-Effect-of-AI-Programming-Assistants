(define (prison-after-n-days cells n)
  (define seen (make-hash))
  (define history (list cells))
  (define current cells)
  (define count 0)

  (let loop ((n n))
    (cond
      [(zero? n) current]
      [else
       (let ((next-cells (next-day current)))
         (cond
           [(hash-has-key? seen next-cells)
            (let ((index (hash-ref seen next-cells)))
              (list-ref history (+ index (modulo n (- index count)))))
            ]
           [else
            (hash-set! seen next-cells count)
            (set! history (append history (list next-cells)))
            (set! current next-cells)
            (set! count (+ count 1))
            (loop (- n 1))]
           ))]))

  )

(define (next-day cells)
  (let ((n (length cells)))
    (let loop ((i 0) (acc '()))
      (cond
        [(= i n) (reverse acc)]
        [(= i 0) (loop (+ i 1) (cons 0 acc))]
        [(= i (- n 1)) (loop (+ i 1) (cons 0 acc))]
        [else
         (let ((prev (list-ref cells (- i 1)))
               (next (list-ref cells (+ i 1))))
           (if (= prev next)
               (loop (+ i 1) (cons 1 acc))
               (loop (+ i 1) (cons 0 acc))))]))))