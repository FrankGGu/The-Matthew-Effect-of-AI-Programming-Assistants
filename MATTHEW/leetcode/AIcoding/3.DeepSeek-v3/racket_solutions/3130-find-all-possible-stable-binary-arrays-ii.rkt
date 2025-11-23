#lang racket

(define (number-of-stable-arrays zero one limit)
  (define mod 1000000007)
  (define dp (make-vector (+ zero 1) (make-vector (+ one 1) (make-vector 3 (make-vector (+ limit 1) 0)))))
  (define (get-dp z o last cnt)
    (if (or (< z 0) (< o 0))
        0
        (vector-ref (vector-ref (vector-ref (vector-ref dp z) o) last) cnt)))
  (define (set-dp! z o last cnt val)
    (vector-set! (vector-ref (vector-ref (vector-ref dp z) o) last) cnt val))

  (for ([z (in-range (+ zero 1))])
    (for ([o (in-range (+ one 1))])
      (for ([last (in-range 3)])
        (for ([cnt (in-range (+ limit 1))])
          (cond
            [(and (= z 0) (= o 0)) (set-dp! z o last cnt 1)]
            [else
             (define res 0)
             (if (= last 0)
                 (if (>= cnt 1)
                     (set! res (modulo (+ res (get-dp (- z 1) o 0 (- cnt 1))) mod))
                     (void))
                 (set! res (modulo (+ res (get-dp (- z 1) o 0 (if (= last 0) (- limit 1) limit))) mod))
             (if (= last 1)
                 (if (>= cnt 1)
                     (set! res (modulo (+ res (get-dp z (- o 1) 1 (- cnt 1))) mod))
                     (void))
                 (set! res (modulo (+ res (get-dp z (- o 1) 1 (if (= last 1) (- limit 1) limit))) mod))
             (set-dp! z o last cnt res)])))))

  (modulo (+ (get-dp zero one 0 limit) (get-dp zero one 1 limit)) mod))