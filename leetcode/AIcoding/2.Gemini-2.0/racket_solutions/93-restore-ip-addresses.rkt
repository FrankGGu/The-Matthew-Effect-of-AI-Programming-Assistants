(define (restore-ip-addresses s)
  (define (valid-ip-part? part)
    (and (>= (string-length part) 1)
         (<= (string-length part) 3)
         (or (= (string-length part) 1)
             (and (not (equal? (substring part 0 1) "0"))
                  (<= (string->number part) 255)))))

  (define (helper s k current-ip result)
    (cond
      [(= k 0)
       (if (equal? (string-length s) 0)
           (list current-ip)
           '())]
      [else
       (let loop ([i 1] [acc '()])
         (cond
           [(> i (min (string-length s) 3)) acc]
           [else
            (let ([part (substring s 0 i)])
              (if (valid-ip-part? part)
                  (append acc (helper (substring s i (string-length s))
                                      (- k 1)
                                      (if (equal? current-ip "") part (string-append current-ip "." part))
                                      result))
                  acc))
            (loop (+ i 1) acc))]))]))

  (helper s 4 "" '()))