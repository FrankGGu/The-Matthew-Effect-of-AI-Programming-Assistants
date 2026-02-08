(define (subdomain-visits cpdomains)
  (define counts (make-hash))
  (for ([cpdomain cpdomains])
    (let* ([parts (string-split cpdomain " ")]
           [count (string->number (car parts))]
           [domain (cadr parts)]
           [subdomains (string-split domain ".")])
      (for/fold ([i (length subdomains)])
                ([subdomain (in-list subdomains)])
        (begin
          (define sub (string-join (list-tail subdomains i) "."))
          (hash-update! counts sub (lambda (v) (+ v count)) count)
          (sub1 i)))))
  (for/list ([(sub c) (in-hash counts)])
    (string-append (number->string c) " " sub)))