(define my-hash%
  (class object%
    (super-new)

    (define size 1000)
    (define buckets (make-vector size null))

    (define (get-bucket key)
      (vector-ref buckets (modulo key size)))

    (define (find-pair bucket key)
      (assoc key bucket))

    (define/public (put key value)
      (let* ([bucket (get-bucket key)]
             [pair (find-pair bucket key)])
        (if pair
            (set-cdr! pair value)
            (let ([new-bucket (cons (cons key value) bucket)])
              (vector-set! buckets (modulo key size) new-bucket))))

    (define/public (get key)
      (let* ([bucket (get-bucket key)]
             [pair (find-pair bucket key)])
        (if pair (cdr pair) -1)))

    (define/public (remove key)
      (let* ([bucket (get-bucket key)]
             [new-bucket (remove-assoc key bucket)])
        (vector-set! buckets (modulo key size) new-bucket))))

(define (make-my-hash)
  (new my-hash%))

(define/contract (design-hashmap)
  (-> any/c)
  (make-my-hash))