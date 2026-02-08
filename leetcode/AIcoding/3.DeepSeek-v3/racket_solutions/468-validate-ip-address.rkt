(define (valid-ip-address query-ip)
  (cond
    [(valid-ipv4? query-ip) "IPv4"]
    [(valid-ipv6? query-ip) "IPv6"]
    [else "Neither"]))

(define (valid-ipv4? ip)
  (let ([parts (string-split ip ".")])
    (and (= (length parts) 4)
         (for/and ([part parts])
           (and (<= (string-length part) 3)
                (not (zero? (string-length part)))
                (or (= (string-length part) 1)
                    (not (char=? (string-ref part 0) #\0)))
                (string->number part)
                (<= 0 (string->number part) 255)))))

(define (valid-ipv6? ip)
  (let ([parts (string-split ip ":")])
    (and (= (length parts) 8)
         (for/and ([part parts])
           (and (<= (string-length part) 4)
                (not (zero? (string-length part)))
                (let ([n (string->number part 16)])
                  (and n (<= 0 n #xffff)))))))