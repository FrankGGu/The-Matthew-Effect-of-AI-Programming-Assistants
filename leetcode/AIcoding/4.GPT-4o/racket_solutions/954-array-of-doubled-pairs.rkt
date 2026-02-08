(define (can-form-array arr)
  (define counts (make-hash))
  (for ([x arr])
    (hash-set! counts x (+ (hash-ref counts x 0) 1)))
  (define sorted-arr (sort arr <))
  (define (helper lst)
    (if (null? lst)
        #t
        (let* ([first (car lst)]
               [double (* 2 first)]
               [count-first (hash-ref counts first 0)]
               [count-double (hash-ref counts double 0)])
          (if (and (> count-first 0) (> count-double 0))
              (begin
                (hash-set! counts first (- count-first 1))
                (hash-set! counts double (- count-double 1))
                (helper (cdr lst)))
              #f))))
  (helper sorted-arr))