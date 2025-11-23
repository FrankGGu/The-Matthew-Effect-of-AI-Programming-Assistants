(define (num-moves-stones-to-continuous-two a b c)
  (let* ([x (min a b c)]
         [y (if (and (= x a) (= x b)) (max a b) (if (and (= x a) (= x c)) (max a c) (if (and (= x b) (= x c)) (max b c) (if (= x a) (max b c) (if (= x b) (max a c) (max a b))))))]
         [z (max a b c)])
    (cond [(= (- z y) 1) 0]
          [(= (- y x) 1) 0]
          [(= (- z y) 2) 1]
          [(= (- y x) 2) 1]
          [else (if (and (= (- y x) 1) (= (- z y) 1)) 0 (+ (if (< (- y x) 2) 1 (- y x)) (if (< (- z y) 2) 1 (- z y))))])))

(define (num-moves-stones-to-continuous a b c)
  (let* ([x (min a b c)]
         [y (if (and (= x a) (= x b)) (max a b) (if (and (= x a) (= x c)) (max a c) (if (and (= x b) (= x c)) (max b c) (if (= x a) (max b c) (if (= x b) (max a c) (max a b))))))]
         [z (max a b c)])
    (if (and (= (- y x) 1) (= (- z y) 1)) 0
        (if (or (= (- y x) 1) (= (- z y) 1)) 1
            (+ (if (< (- y x) 2) 1 (- y x)) (if (< (- z y) 2) 1 (- z y)))))))

(define (possible a b c)
  (let* ([x (min a b c)]
         [y (if (and (= x a) (= x b)) (max a b) (if (and (= x a) (= x c)) (max a c) (if (and (= x b) (= x c)) (max b c) (if (= x a) (max b c) (if (= x b) (max a c) (max a b))))))]
         [z (max a b c)])
    (and (= (- y x) 1) (= (- z y) 1))))

(define (num-moves-stones a b c)
  (let* ([x (min a b c)]
         [y (if (and (= x a) (= x b)) (max a b) (if (and (= x a) (= x c)) (max a c) (if (and (= x b) (= x c)) (max b c) (if (= x a) (max b c) (if (= x b) (max a c) (max a b))))))]
         [z (max a b c)])
    (if (and (= (- y x) 1) (= (- z y) 1)) 0
        (if (or (= (- y x) 1) (= (- z y) 1)) 1
            (+ (if (< (- y x) 2) 1 (- y x)) (if (< (- z y) 2) 1 (- z y)))))))

(define (num-moves-stones-ii a b c)
  (let* ([x (min a b c)]
         [y (if (and (= x a) (= x b)) (max a b) (if (and (= x a) (= x c)) (max a c) (if (and (= x b) (= x c)) (max b c) (if (= x a) (max b c) (if (= x b) (max a c) (max a b))))))]
         [z (max a b c)])
    (if (and (= (- y x) 1) (= (- z y) 1)) 0
        (if (or (= (- y x) 1) (= (- z y) 1)) 1
            (+ (if (< (- y x) 2) 1 (- y x)) (if (< (- z y) 2) 1 (- z y)))))))

(define (moves a b c)
  (let* ([x (min a b c)]
         [y (if (and (= x a) (= x b)) (max a b) (if (and (= x a) (= x c)) (max a c) (if (and (= x b) (= x c)) (max b c) (if (= x a) (max b c) (if (= x b) (max a c) (max a b))))))]
         [z (max a b c)])
    (if (and (= (- y x) 1) (= (- z y) 1)) 0
        (if (or (= (- y x) 1) (= (- z y) 1)) 1
            (+ (if (< (- y x) 2) 1 (- y x)) (if (< (- z y) 2) 1 (- z y)))))))

(define (num-moves-stones-until-consecutive-ii a b c)
  (let* ([x (min a b c)]
         [y (if (and (= x a) (= x b)) (max a b) (if (and (= x a) (= x c)) (max a c) (if (and (= x b) (= x c)) (max b c) (if (= x a) (max b c) (if (= x b) (max a c) (max a b))))))]
         [z (max a b c)])
    (if (and (= (- y x) 1) (= (- z y) 1)) 0
        (if (or (= (- y x) 1) (= (- z y) 1)) 1
            (+ (if (< (- y x) 2) 1 (- y x)) (if (< (- z y) 2) 1 (- z y)))))))