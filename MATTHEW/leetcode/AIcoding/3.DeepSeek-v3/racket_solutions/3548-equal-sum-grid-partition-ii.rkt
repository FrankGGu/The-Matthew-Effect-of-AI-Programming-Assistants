#lang racket

(define (can-partition nums)
  (let* ([total (apply + nums)]
         [half (/ total 2)]
         [n (length nums)])
    (if (not (integer? half))
        #f
        (let loop ([i 0] [sum 0] [used (make-vector n 0)])
          (cond
            [(= sum half) #t]
            [(>= i n) #f]
            [else
             (or (and (= (vector-ref used i) 0)
                      (vector-set! used i 1)
                      (loop (+ i 1) (+ sum (list-ref nums i)) used)
                      (vector-set! used i 0))
                 (loop (+ i 1) sum used))])))))

(define (can-partition-k-subsets nums k)
  (let* ([total (apply + nums)]
         [target (/ total k)]
         [n (length nums)])
    (if (or (not (integer? target)) (zero? total))
        #f
        (let loop ([k k] [sum 0] [start 0] [used (make-vector n 0)])
          (cond
            [(= k 1) #t]
            [(= sum target) (loop (- k 1) 0 0 used)]
            [else
             (let try ([i start] [sum sum] [used used])
               (cond
                 [(>= i n) #f]
                 [(and (= (vector-ref used i) 0) (<= (+ sum (list-ref nums i)) target))
                  (vector-set! used i 1)
                  (if (try (+ i 1) (+ sum (list-ref nums i)) used)
                      #t
                      (begin
                        (vector-set! used i 0)
                        (try (+ i 1) sum used)))]
                 [else (try (+ i 1) sum used)]))]))))

(define (equal-sum-grid-partition-II grid)
  (let* ([rows (length grid)]
         [cols (if (null? grid) 0 (length (car grid)))]
         [nums (append* grid)]
         [total (apply + nums)]
         [half (/ total 2)])
    (if (not (integer? half))
        #f
        (can-partition nums))))