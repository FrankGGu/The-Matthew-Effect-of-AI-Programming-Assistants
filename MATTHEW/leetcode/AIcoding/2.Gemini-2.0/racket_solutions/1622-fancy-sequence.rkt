(define (fancy-sequence n)
  (define seq (make-vector n 0))
  (define mults (make-vector n 1))
  (define adds (make-vector n 0))
  (define (mod x) (modulo x 1000000007))

  (define (append val)
    (vector-set! seq (vector-length seq) val)
    (vector-set! mults (vector-length seq) 1)
    (vector-set! adds (vector-length seq) 0))

  (define (addinc i inc)
    (cond [(< i (vector-length adds))
           (vector-set! adds i (mod (+ (vector-ref adds i) inc)))]))

  (define (multall m)
    (let loop ([i 0])
      (cond [(< i (vector-length mults))
             (vector-set! mults i (mod (* (vector-ref mults i) m)))
             (vector-set! adds i (mod (* (vector-ref adds i) m)))
             (loop (+ i 1))]
            [else #t])))

  (define (addall inc)
    (let loop ([i 0])
      (cond [(< i (vector-length adds))
             (vector-set! adds i (mod (+ (vector-ref adds i) inc)))
             (loop (+ i 1))]
            [else #t])))

  (define (getindex i)
    (cond [(< i (vector-length seq))
           (let ([m (vector-ref mults i)]
                 [a (vector-ref adds i)]
                 [v (vector-ref seq i)])
             (mod (+ (mod (* v m)) a)))]
          [else -1]))

  (define (pow a b mod)
    (letrec ([pow-helper (lambda (a b result)
                           (if (= b 0)
                               result
                               (if (odd? b)
                                   (pow-helper (mod (* a a)) (quotient b 2) (mod (* result a)))
                                   (pow-helper (mod (* a a)) (quotient b 2) result))))])
      (pow-helper a b 1)))

  (define (inv a mod)
    (pow a (- mod 2) mod))

  (define (multinc i m)
    (cond [(< i (vector-length mults))
           (vector-set! mults i (mod (* (vector-ref mults i) m)))]))

  (define (fancy-sequence-dispatch op . args)
    (case op
      ((append) (append (car args)))
      ((addall) (addall (car args)))
      ((multall) (multall (car args)))
      ((getIndex) (getindex (car args)))
      (else (error "Invalid operation"))))

  (define (make-fancy-sequence)
    (lambda (op . args)
      (apply fancy-sequence-dispatch op args)))

  (make-fancy-sequence))