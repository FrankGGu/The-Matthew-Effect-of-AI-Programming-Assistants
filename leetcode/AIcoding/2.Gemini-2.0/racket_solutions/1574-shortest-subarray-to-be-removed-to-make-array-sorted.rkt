(define (find-length-of-shortest-subarray arr)
  (define n (length arr))
  (define (helper left right)
    (cond
      [(>= left right) 0]
      [else
       (let* ([len (length arr)]
              [i left]
              [j right])
         (cond
           [(and (<= i (- len 2)) (>= j 1) (<= (list-ref arr i) (list-ref arr (+ i 1))) (>= (list-ref arr j) (list-ref arr (- j 1))))
            (min (+ 1 (helper (+ left 1) right))
                 (+ 1 (helper left (- right 1)))
                 (- right left 1))]
           [(<= i (- len 2)) (if (<= (list-ref arr i) (list-ref arr (+ i 1)))
                                  (+ 1 (helper (+ left 1) right))
                                  (+ 1 (helper (+ left 1) right)))]
           [(>= j 1) (if (>= (list-ref arr j) (list-ref arr (- j 1)))
                          (+ 1 (helper left (- right 1)))
                          (+ 1 (helper left (- right 1))))]
           [else (- len 1)]))]))
  (let loop ([left 0] [right (- n 1)])
    (cond
      [(>= left right) 0]
      [else
       (let ([left-sorted (let loop ([i 0])
                              (cond
                                [(= i (- n 1)) n]
                                [(> (list-ref arr i) (list-ref arr (+ i 1))) i]
                                [else (loop (+ i 1))]))]
             [right-sorted (let loop ([i (- n 1)])
                               (cond
                                 [(= i 0) -1]
                                 [(< (list-ref arr i) (list-ref arr (- i 1))) i]
                                 [else (loop (- i 1))]))])
         (if (and (= left-sorted n) (= right-sorted -1))
             0
             (let ([ans (- right-sorted left-sorted 1)])
               (if (or (= left-sorted n) (= right-sorted -1))
                   (min (- n left-sorted) (+ right-sorted 1))
                   (let loop ([l 0] [r right-sorted] [result ans])
                     (cond
                       [(> l left-sorted) result]
                       [else
                        (let next-loop ([rr r])
                          (cond
                            [(< rr left-sorted) result]
                            [(>= l (- n 1)) result]
                            [else
                             (if (>= (list-ref arr rr) (list-ref arr l))
                                 (loop (+ l 1) right-sorted (min result (- rr l 1)))
                                 (next-loop (- rr 1)))]))]))))))]))))