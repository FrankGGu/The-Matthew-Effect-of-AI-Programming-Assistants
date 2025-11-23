(define (max-operations nums k)
  (let ((counts (make-hash)))
    (for-each (lambda (x)
                (hash-update! counts x (lambda (v) (+ v 1)) 1))
              nums))
  (let loop ((operations 0))
    (cond [(hash-empty? counts) operations]
          [else
           (let* ((num (hash-first-key counts))
                  (complement (- k num)))
             (cond [(not (hash-has-key? counts complement))
                    (hash-remove! counts num)
                    (loop operations)]
                   [else
                    (let ((num-count (hash-ref counts num))
                          (complement-count (hash-ref counts complement)))
                      (cond [(and (= num complement) (< num-count 2))
                             (hash-remove! counts num)
                             (loop operations)]
                            [(and (= num complement))
                             (hash-update! counts num (lambda (v) (- v 2)) 0)
                             (when (zero? (hash-ref counts num))
                               (hash-remove! counts num))
                             (loop (+ operations 1))]
                            [else
                             (hash-update! counts num (lambda (v) (- v 1)) 0)
                             (hash-update! counts complement (lambda (v) (- v 1)) 0)
                             (when (zero? (hash-ref counts num))
                               (hash-remove! counts num))
                             (when (zero? (hash-ref counts complement))
                               (hash-remove! counts complement))
                             (loop (+ operations 1))])]))]))])))