(define/contract (subdomain-visits cpdomains)
  (-> (listof string?) (listof string?))
  (define counts (make-hash))
  (for ([cpdomain cpdomains])
    (let* ([parts (string-split cpdomain " ")]
           [count (string->number (first parts))]
           [domain (second parts)]
           [subdomains (regexp-match* #rx"[^.]+" domain)])
      (for ([i (in-range (length subdomains))])
        (let ([subdomain (string-join (drop subdomains i) ".")])
          (hash-update! counts subdomain (lambda (v) (+ v count)) (lambda () 0))))))
  (for/list ([(subdomain count) (in-hash counts)])
    (format "~a ~a" count subdomain)))