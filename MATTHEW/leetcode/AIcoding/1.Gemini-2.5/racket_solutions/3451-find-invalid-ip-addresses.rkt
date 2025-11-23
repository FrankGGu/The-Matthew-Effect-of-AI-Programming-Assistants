#lang racket

(define (is-valid-octet? octet-str)
  (let ([len (string-length octet-str)])
    (cond
      [(zero? len) #f]
      [(and (> len 1) (char=? #\0 (string-ref octet-str 0))) #f]
      [(not (andmap char-numeric? (string->list octet-str))) #f]
      [else
       (let ([num (string->number octet-str)])
         (and num (>= num 0) (<= num 255)))])))

(define (is-valid-ip-address? s)
  (let ([parts (string-split s ".")])
    (and (= (length parts) 4)
         (andmap is-valid-octet? parts))))

(define (find-invalid-ip-addresses ip-address-list)
  (filter (lambda (ip) (not (is-valid-ip-address? ip))) ip-address-list))