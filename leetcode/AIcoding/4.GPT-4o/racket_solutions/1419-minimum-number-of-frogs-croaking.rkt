(define (min-frogs croak-of-frogs)
  (define croak "croak")
  (define counts (make-vector 5 0))
  (define frogs 0)
  (define result 0)

  (for-each (lambda (ch)
              (define idx (string-index croak ch))
              (if idx
                  (begin
                    (vector-set! counts idx (+ 1 (vector-ref counts idx)))
                    (if (= idx 0)
                        (begin (set! frogs (+ frogs 1))
                               (set! result (max result frogs)))
                        (when (zero? (vector-ref counts (- idx 1)))
                          (set! frogs -1)))))
                  (set! frogs -1)))
            (string->list croak-of-frogs))

  (if (or (< frogs 0) (not (= (vector-ref counts 0) (vector-ref counts 4))))
      -1
      result))