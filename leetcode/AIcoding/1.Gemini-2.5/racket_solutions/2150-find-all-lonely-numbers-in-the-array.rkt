(define (find-all-lonely-numbers nums)
  (define freq (make-hash))

  ;; Populate frequency hash
  (for-each (lambda (num)
              (hash-update! freq num add1 0))
            nums)

  ;; Filter lonely numbers
  (filter (lambda (num)
            (and (= (hash-ref freq num 0) 1)
                 (= (hash-ref freq (- num 1) 0) 0)
                 (= (hash-ref freq (+ num 1) 0) 0)))
          nums))