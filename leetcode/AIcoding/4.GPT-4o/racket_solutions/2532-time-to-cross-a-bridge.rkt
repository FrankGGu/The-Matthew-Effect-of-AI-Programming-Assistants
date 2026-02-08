(define (findCrossingTime n k time)
  (define (canCross time)
    (define workers 0)
    (define index 0)
    (define queue (list))
    (define (process-queue)
      (if (null? queue)
          0
          (let ((next-time (car queue)))
            (set! queue (cdr queue))
            (if (<= next-time time)
                (begin
                  (set! workers (add1 workers))
                  (process-queue))
                (begin
                  (set! queue (cons next-time queue))
                  workers)))))
    (do ((i 0 (add1 i)))
        ((= i n))
      (let ((arrival-time (+ (car (list-ref time i)) (if (= i 0) 0 (car (last queue))))))
        (set! queue (cons arrival-time queue))))
    (process-queue))

  (define low 0)
  (define high (* n (car (last time))))
  (define result high)

  (while (< low high)
    (define mid (quotient (+ low high) 2))
    (if (>= (canCross mid) k)
        (begin
          (set! result mid)
          (set! high mid))
        (set! low (add1 mid))))

  result)