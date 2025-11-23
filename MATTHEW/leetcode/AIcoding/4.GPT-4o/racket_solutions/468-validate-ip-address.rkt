(define (validIPAddress IP)
  (define (is-valid-ipv4 segment)
    (and (not (string-blank? segment))
         (let ((num (string->number segment)))
           (and (>= num 0) (< num 256)
                (if (string=? segment "0")
                    #t
                    (not (string-prefix? "0" segment)))))))

  (define (is-valid-ipv6 segment)
    (and (not (string-blank? segment))
         (let ((len (string-length segment)))
           (and (<= len 4)
                (string->number segment) (or (string-contains? segment "abcdef") #t)
                (string->number segment)))))

  (define split-ip (string-split IP ":"))
  (define split-ipv4 (string-split IP "."))

  (if (and (= (length split-ip) 8) (for/and ([seg split-ip]) (is-valid-ipv6 seg)))
      "IPv6"
      (if (and (= (length split-ipv4) 4) (for/and ([seg split-ipv4]) (is-valid-ipv4 seg)))
          "IPv4"
          "Neither")))