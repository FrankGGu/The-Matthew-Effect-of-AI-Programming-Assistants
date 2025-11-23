(define (restore-ip-addresses s)
  (define (valid-octet? octet)
    (and (>= (string->number octet) 0)
         (<= (string->number octet) 255)
         (or (= (string-length octet) 1)
             (and (not (string=? (substring octet 0 1) "0"))
                  (= (string-length octet) (number->string (string->number octet)))))))

  (define (helper s current-ip octets-left)
    (cond
      [(= octets-left 0)
       (if (string=? s "")
           (list (string-join current-ip "."))
           '())]
      [else
       (let loop ([i 1] [result '()])
         (cond
           [(> i (min 3 (string-length s))) result]
           [else
            (let ([octet (substring s 0 i)])
              (if (valid-octet? octet)
                  (loop (+ i 1) (append result (helper (substring s i) (append current-ip (list octet)) (- octets-left 1))))
                  (loop (+ i 1) result)))]))]))

  (helper s '() 4))