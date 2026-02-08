#lang racket

(define (validate-ip-address IP)

  (define (is-valid-ipv4-segment? s)
    (cond
      [(string-null? s) #f]
      [(and (> (string-length s) 1) (char=? (string-ref s 0) #\0)) #f]
      [(not (regexp-match? #rx"^[0-9]+$" s)) #f]
      [else
       (define num (string->number s))
       (and (number? num) (>= num 0) (<= num 255))]))

  (define (is-valid-ipv6-segment? s)
    (cond
      [(or (< (string-length s) 1) (> (string-length s) 4)) #f]
      [(not (regexp-match? #rx"^[0-9a-fA-F]+$" s)) #f]
      [else #t]))

  (cond
    [(string-contains IP ".")
     (define parts (string-split IP "."))
     (if (and (= (length parts) 4)
              (andmap is-valid-ipv4-segment? parts))
         "IPv4"
         "Neither")]
    [(string-contains IP ":")
     (define parts (string-split IP ":"))
     (if (and (= (length parts) 8)
              (andmap is-valid-ipv6-segment? parts))
         "IPv6"
         "Neither")]
    [else "Neither"]))