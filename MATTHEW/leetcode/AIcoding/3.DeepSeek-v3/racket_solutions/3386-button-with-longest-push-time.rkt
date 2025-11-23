(define (longest-push-time buttons)
  (let loop ([i 0] [current-start 0] [max-time 0] [pressed? #f])
    (cond
      [(= i (vector-length buttons))
       (if pressed?
           (max max-time (- (vector-length buttons) current-start))
           max-time)]
      [pressed?
       (if (zero? (vector-ref buttons i))
           (loop (add1 i) i (max max-time (- i current-start)) #f)
           (loop (add1 i) current-start max-time #t))]
      [else
       (if (zero? (vector-ref buttons i))
           (loop (add1 i) current-start max-time #f)
           (loop (add1 i) i max-time #t))])))