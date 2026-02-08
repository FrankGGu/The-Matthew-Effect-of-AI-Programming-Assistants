(define (most-frequent-even nums)
  (define counts (make-hash))
  (for-each (lambda (num)
              (when (even? num)
                (hash-set! counts num (+ (hash-ref counts num 0) 1))))
            nums)

  (if (hash-empty? counts)
      -1
      (begin
        (define max-freq 0)
        (define result -1)

        (define first-key (car (hash-keys counts)))
        (set! max-freq (hash-ref counts first-key))
        (set! result first-key)

        (hash-for-each
         (lambda (num freq)
           (when (> freq max-freq)
             (set! max-freq freq)
             (set! result num))
           (when (and (= freq max-freq)
                      (< num result))
             (set! result num)))
         counts)
        result)))