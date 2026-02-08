(define (most-common-response responses)
  (let ((counts (make-hash)))
    (for ([response responses])
      (hash-update! counts response add1 (lambda () 0)))
    (let* ([max-count (apply max (hash-values counts))]
           [most-commons (filter (lambda (x) (= (hash-ref counts x) max-count)) (hash-keys counts))])
      (car (sort most-commons string<?)))))