#lang racket

(define MOD 1000000007)

(define (power base exp)
  (let loop ((b base) (e exp) (res 1))
    (cond
      ((zero? e) res)
      ((odd? e) (loop (modulo (* b b) MOD) (quotient e 2) (modulo (* res b) MOD)))
      (else (loop (modulo (* b b) MOD) (quotient e 2) res)))))

(define (get-v2 n)
  (cond
    ((zero? n) 0)
    (else
     (let loop ((num n) (count 0))
       (cond
         ((odd? num) count)
         (else (loop (quotient num 2) (add1 count))))))))

(define (get-odd-part n)
  (cond
    ((zero? n) 0)
    (else
     (let loop ((num n))
       (cond
         ((odd? num) num)
         (else (loop (quotient num 2))))))))

(define (solve nums k)
  (define MAX-V2-OF-ANY-SUM (get-v2 (* 100 1000000000)))
  (define MAX-V2-OF-ODD-SUM-PART (get-v2 (* 2 100000000000)))

  (define MAX-J (+ MAX-V2-OF-ANY-SUM MAX-V2-OF-ODD-SUM-PART))

  (define C-val (add1 MAX-V2-OF-ODD-SUM-PART))
  (define MOD-P-val (expt 2 C-val))

  (define k-powers (make-vector (add1 MAX-J) 0))
  (for ((j (in-range (add1 MAX-J))))
    (vector-set! k-powers j (power k j)))

  (define dp (make-vector (add1 MAX-J) (make-hash)))

  (for ((x nums))
    (define next-dp (make-vector (add1 MAX-J) (make-hash)))

    (for ((j (in-range (add1 MAX-J))))
      (hash-for-each (vector-ref dp j)
                     (lambda (p val)
                       (hash-set! (vector-ref next-dp j) p (modulo (+ (hash-ref (vector-ref next-dp j) p 0) val) MOD)))))

    (define v2-x (get-v2 x))
    (define odd-x (get-odd-part x))
    (define odd-x-mod-P (modulo odd-x MOD-P-val))

    (when (<= v2-x MAX-J)
      (hash-set! (vector-ref next-dp v2-x) odd-x-mod-P
                 (modulo (+ (hash-ref (vector-ref next-dp v2-x) odd-x-mod-P 0)
                            (vector-ref k-powers v2-x))
                         MOD)))

    (for ((j-prev (in-range (add1 MAX-J))))
      (hash-for-each (vector-ref dp j-prev)
                     (lambda (p-prev val-prev)
                       (cond
                         ((< j-prev v2-x)
                          (define new-j j-prev)
                          (define new-p p-prev)
                          (hash-set! (vector-ref next-dp new-j) new-p
                                     (modulo (+ (hash-ref (vector-ref next-dp new-j) new-p 0) val-prev) MOD)))

                         ((> j-prev v2-x)
                          (define new-j v2-x)
                          (define new-p odd-x-mod-P)
                          (hash-set! (vector-ref next-dp new-j) new-p
                                     (modulo (+ (hash-ref (vector-ref next-dp new-j) new-p 0) val-prev) MOD)))

                         (else
                          (define sum-of-p-values (+ p-prev odd-x-mod-P))
                          (define v2-sum-of-p (get-v2 sum-of-p-values))

                          (define new-j (+ j-prev v2-sum-of-p))
                          (when (<= new-j MAX-J)
                            (define new-p (modulo (get-odd-part sum-of-p-values) MOD-P-val))
                            (hash-set! (vector-ref next-dp new-j) new-p
                                       (modulo (+ (hash-ref (vector-ref next-dp new-j) new-p 0) val-prev) MOD))))))))
    (set! dp next-dp))

  (let loop ((total-sum 0) (j 0))
    (cond
      ((> j MAX-J) total-sum)
      (else
       (let ((j-sum (hash-fold (lambda (p val acc) (modulo (+ acc val) MOD)) 0 (vector-ref dp j))))
         (loop (modulo (+ total-sum j-sum) MOD) (add1 j)))))))