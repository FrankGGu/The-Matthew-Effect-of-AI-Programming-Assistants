(define (validIPAddress IP)
  (define (valid-ipv4? s)
    (and (string? s)
         (let ((parts (string-split s ".")))
           (and (= (length parts) 4)
                (andmap (lambda (p)
                          (and (regexp-match? #rx"^[0-9]+$" p)
                               (let ((n (string->number p)))
                                 (and (not (equal? (string->number p) #f))
                                      (<= 0 n)
                                      (<= n 255)
                                      (or (= (string-length p) 1)
                                          (not (equal? (string-ref p 0) #\0)))))))
                        parts)))))

  (define (valid-ipv6? s)
    (and (string? s)
         (let ((parts (string-split s ":")))
           (and (= (length parts) 8)
                (andmap (lambda (p)
                          (and (regexp-match? #rx"^[0-9a-fA-F]+$" p)
                               (<= (string-length p) 4)
                               (not (string=? p ""))))
                        parts)))))

  (cond
    [(valid-ipv4? IP) "IPv4"]
    [(valid-ipv6? IP) "IPv6"]
    [else "Neither"]))