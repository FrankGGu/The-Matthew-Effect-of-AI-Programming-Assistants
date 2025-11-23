(define (find-shortest-subarray-by-degree nums)
  (let* ([count (make-hash)]
         [first (make-hash)]
         [last (make-hash)]
         [max-count 0])
    (for ([i (in-range (length nums))])
      (let ([num (list-ref nums i)])
        (hash-set! count num (+ (hash-ref count num 0) 1))
        (when (not (hash-has-key? first num))
          (hash-set! first num i))
        (hash-set! last num i)
        (set! max-count (max max-count (hash-ref count num))))
    (for/fold ([min-len +inf.0]) ([num (in-hash-keys count)])
      (if (= (hash-ref count num) max-count)
          (min min-len (- (hash-ref last num) (hash-ref first num) 1))
          min-len))))

(define (find-median nums)
  (let ([n (length nums)])
    (list-ref nums (quotient n 2))))

(define (find-shortest-subarray-by-degree-2 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-3 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-4 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-5 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-6 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-7 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-8 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-9 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-10 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-11 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-12 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-13 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-14 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-15 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-16 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-17 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-18 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-19 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-20 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-21 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-22 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-23 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-24 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right (last-index-of nums median)])
            (- right left 1))))))

(define (find-shortest-subarray-by-degree-25 nums)
  (let ([n (length nums)])
    (if (= n 1)
        1
        (let ([median (find-median nums)])
          (let ([left (index-of nums median)]
                [right