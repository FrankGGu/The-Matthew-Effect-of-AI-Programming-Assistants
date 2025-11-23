(define (make-hash-map)
  (make-vector 1000000 #f))

(define (put hash-map key value)
  (vector-set! hash-map key value))

(define (get hash-map key)
  (let ([val (vector-ref hash-map key)])
    (if (equal? val #f)
        -1
        val)))

(define (remove hash-map key)
  (vector-set! hash-map key #f))