#lang racket

(define (check-record n)
  (define MOD 1000000007)
  (define (dp n)
    (if (= n 0)
        1
        (let* ([prev (dp (- n 1))]
               [a (modulo prev MOD)]
               [l (if (>= n 2) (modulo (- (dp (- n 2)) (if (>= n 3) (dp (- n 3)) 0)) MOD) 0)]
               [ll (if (>= n 2) (modulo (- (dp (- n 2)) (if (>= n 4) (dp (- n 4)) 0)) MOD) 0)])
          (modulo (+ a l ll) MOD))))
  (if (= n 0)
      0
      (let* ([total (dp n)]
             [with-a (for/sum ([i n])
                       (modulo (* (dp i) (dp (- n i 1))) MOD))])
        (modulo (+ total with-a) MOD))))

(define (check-record-optimized n)
  (define MOD 1000000007)
  (if (= n 0)
      0
      (let ()
        (define memo (make-hash))
        (define (dp n)
          (hash-ref! memo n
                     (λ ()
                       (if (= n 0)
                           1
                           (let* ([prev (dp (- n 1))]
                                  [a (modulo prev MOD)]
                                  [l (if (>= n 2) (modulo (- (dp (- n 2)) (if (>= n 3) (dp (- n 3)) 0) MOD) 0)]
                                  [ll (if (>= n 2) (modulo (- (dp (- n 2)) (if (>= n 4) (dp (- n 4)) 0) MOD) 0)])
                             (modulo (+ a l ll) MOD))))))
        (let* ([total (dp n)]
               [with-a (for/sum ([i n])
                         (modulo (* (dp i) (dp (- n i 1))) MOD))])
          (modulo (+ total with-a) MOD)))))

(define (check-record-fast n)
  (define MOD 1000000007)
  (if (= n 0)
      0
      (let ()
        (define (pow a b)
          (define res 1)
          (let loop ([a a] [b b])
            (when (> b 0)
              (when (odd? b)
                (set! res (modulo (* res a) MOD)))
              (set! a (modulo (* a a) MOD))
              (set! b (arithmetic-shift b -1))))
          res)
        (define inv6 (pow 6 (- MOD 2)))
        (define inv2 (pow 2 (- MOD 2)))
        (define (f n)
          (modulo (+ (pow 2 (+ n 1)) (- (pow 1 (+ n 1))) (- (pow 0 (+ n 1)))) MOD))
        (define (g n)
          (modulo (* inv6 (modulo (+ (pow 4 (+ n 1)) (* -2 (pow 2 (+ n 1))) (pow 0 (+ n 1))) MOD)) MOD))
        (define (h n)
          (modulo (* inv2 (modulo (- (pow 3 (+ n 1)) (pow 1 (+ n 1))) MOD)) MOD))
        (modulo (+ (f n) (g n) (h n)) MOD))))

(define (check-record n)
  (check-record-optimized n))