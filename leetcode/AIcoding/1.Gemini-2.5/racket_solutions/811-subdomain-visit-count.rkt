(define (subdomain-visits cpdomains)
  (define domain-counts (make-hash))

  (for-each
   (lambda (cpdomain-str)
     (define parts (string-split cpdomain-str " "))
     (define count (string->number (first parts)))
     (define full-domain (second parts))

     (let loop ((current-domain full-domain))
       (hash-set! domain-counts
                  current-domain
                  (+ count (hash-ref domain-counts current-domain 0)))

       (define first-dot-idx (string-find current-domain "."))
       (when first-dot-idx
         (loop (substring current-domain (+ first-dot-idx 1))))))
   cpdomains)

  (map
   (lambda (domain)
     (string-append (number->string (hash-ref domain-counts domain))
                    " "
                    domain))
   (hash-keys domain-counts)))