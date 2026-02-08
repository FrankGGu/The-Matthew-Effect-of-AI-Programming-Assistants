(define (contains-nearby-duplicate nums k)
  (let ((seen (make-hash)))
    (for/or ((i (in-range (length nums))))
      (let ((num (list-ref nums i)))
        (if (hash-has-key? seen num)
            (let ((prev-index (hash-ref seen num)))
              (if (<= (- i prev-index) k)
                  #t
                  (begin
                    (hash-set! seen num i)
                    #f)))
            (begin
              (hash-set! seen num i)
              #f))))))