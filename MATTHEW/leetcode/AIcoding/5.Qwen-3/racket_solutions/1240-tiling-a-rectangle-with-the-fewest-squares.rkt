#lang racket

(define (tilling-rectangle n m)
  (define memo (make-hash))
  (define (dfs a b)
    (if (= a b) 1
        (let ((min-squares (add1 (* a b))))
          (for ([i (in-range 1 (floor (/ a 2)))]
                #:when (<= (* i i) (* a b)))
            (when (>= a i)
              (set! min-squares (min min-squares (+ (dfs i b) (dfs (- a i) b)))))
            (when (>= b i)
              (set! min-squares (min min-squares (+ (dfs a i) (dfs a (- b i))))))
            (when (and (>= a i) (>= b i))
              (set! min-squares (min min-squares (+ (dfs i i) (dfs (- a i) b) (dfs a (- b i))))))
            (when (and (>= a i) (>= b i))
              (set! min-squares (min min-squares (+ (dfs i i) (dfs (- a i) (- b i)) (dfs a (- b i)) (dfs (- a i) b)))))
            (when (and (>= a i) (>= b i))
              (set! min-squares (min min-squares (+ (dfs i i) (dfs (- a i) b) (dfs a (- b i)) (dfs (- a i) (- b i)))))))
          min-squares)))
  (if (> n m) (dfs m n) (dfs n m)))

(define (main)
  (let ([n (read)] [m (read)])
    (printf "~a\n" (tilling-rectangle n m))))

(main)