(define (make-booking-system n m)
  (let ([seats (make-vector n m)])
    (vector
     (lambda (k max_seats)
       (let loop ([i 0])
         (cond
           [(= i n) false]
           [(< (- m (vector-sum seats i)) max_seats)
            (let loop2 ([j 0])
              (cond
                [(= j m) false]
                [(and (< j m) (< (+ (vector-ref seats i j) k) m))
                 (for ([l (in-range j (+ j k))])
                   (vector-set! seats i l (+ 1 (vector-ref seats i l))))
                 (vector-sum seats i)
                 ]
                [else (loop2 (+ j 1))]))]
           [else (loop (+ i 1))])))
     (lambda (k max_seats)
       (let loop ([i 0])
         (cond
           [(= i n) false]
           [(< (- m (vector-sum seats i)) max_seats)
            (let loop2 ([j 0])
              (cond
                [(= j m) false]
                [(and (< j m) (>= (- m (vector-sum seats i)) (+ k (vector-ref seats i j))))
                 (for ([l (in-range j (+ j k))])
                   (vector-set! seats i l (+ 1 (vector-ref seats i l))))
                 (vector-sum seats i)
                 ]
                [else (loop2 (+ j 1))]))]
           [else (loop (+ i 1))])))
     (lambda ()
       (let loop ([i 0] [min-row -1] [min-seats m])
         (cond
           [(= i n) min-row]
           [(= (- m (vector-sum seats i)) 0) (loop (+ i 1) min-row min-seats)]
           [(< (- m (vector-sum seats i)) min-seats) (loop (+ i 1) i (- m (vector-sum seats i)))]
           [else (loop (+ i 1) min-row min-seats)])))
     seats)))

(define (book-seats-in-groups booking-system k max_seats)
  ((vector-ref booking-system 0) k max_seats))

(define (scatter booking-system k max_seats)
  ((vector-ref booking-system 1) k max_seats))

(define (best-row booking-system)
  ((vector-ref booking-system 2)))

(define (vector-sum vec i)
  (let loop ([j 0] [sum 0])
    (cond
      [(= j (vector-length vec)) sum]
      [else (loop (+ j 1) (+ sum (vector-ref vec j i)))])))