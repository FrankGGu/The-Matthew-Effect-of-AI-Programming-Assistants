(define map-sum%
  (class object%
    (super-new)
    (init-field)
    (define h (make-hash))

    (define/public (insert key val)
      (hash-set! h key val))

    (define/public (sum prefix)
      (for/sum ([(k v) (in-hash h)]
        #:when (string-prefix? k prefix)
        v))))

(define (make-map-sum) (new map-sum%))