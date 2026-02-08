#lang racket

(define (getMaxGridHappiness m n introvertsCount extrovertsCount)
  (define max-state (expt 3 n))
  (define dp (make-hash))
  (define memo (make-hash))

  (define (calc (i 0) (j 0) (mask 0) (ic introvertsCount) (ec extrovertsCount))
    (if (or (= i m) (and (= ic 0) (= ec 0)))
        0
        (let ([key (list i j mask ic ec)])
          (if (hash-has-key? memo key)
              (hash-ref memo key)
              (let* ([next-i (if (= j (- n 1)) (+ i 1) i)]
                     [next-j (if (= j (- n 1)) 0 (+ j 1))]
                     [up (if (> i 0) (quotient (remainder mask (* (expt 3 (- n 1)) 3)) (expt 3 (- n 1))) 0)]
                     [left (if (> j 0) (remainder mask 3) 0)]
                     [res 0])
                (for ([x (in-range 3)])
                  (when (or (and (= x 1) (> ic 0)) (and (= x 2) (> ec 0)))
                    (let* ([new-mask (+ (* (remainder mask (expt 3 (- n 1))) 3) x)]
                           [new-ic (if (= x 1) (- ic 1) ic)]
                           [new-ec (if (= x 2) (- ec 1) ec)]
                           [gain 0])
                      (when (= x 1)
                        (set! gain (+ gain 120))
                        (when (= up 1) (set! gain (- gain 30)))
                        (when (= up 2) (set! gain (- gain 20)))
                        (when (= left 1) (set! gain (- gain 30)))
                        (when (= left 2) (set! gain (- gain 20))))
                      (when (= x 2)
                        (set! gain (+ gain 40))
                        (when (= up 1) (set! gain (- gain 20)))
                        (when (= up 2) (set! gain (+ gain 40)))
                        (when (= left 1) (set! gain (- gain 20)))
                        (when (= left 2) (set! gain (+ gain 40))))
                      (set! res (max res (+ gain (calc next-i next-j new-mask new-ic new-ec)))))))
                (hash-set! memo key res)
                res)))))

  (calc))