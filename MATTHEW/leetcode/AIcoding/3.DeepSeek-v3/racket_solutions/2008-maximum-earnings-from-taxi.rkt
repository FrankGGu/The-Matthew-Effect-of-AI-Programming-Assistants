(define/contract (max-taxi-earnings n rides)
  (-> exact-integer? (listof (listof exact-integer?)) exact-integer?)
  (define sorted-rides (sort rides (lambda (a b) (< (car a) (car b)))))
  (define m (length rides))
  (define dp (make-vector (add1 m) 0))

  (for ([i (in-range (sub1 m) -1 -1)])
    (define ride (list-ref sorted-rides i))
    (define start (first ride))
    (define end (second ride))
    (define tip (third ride))
    (define earnings (+ (- end start) tip))

    (define low (add1 i))
    (define high m)
    (define next-ride m)
    (while (< low high)
      (define mid (quotient (+ low high) 2))
      (if (>= (first (list-ref sorted-rides mid)) end)
          (begin
            (set! next-ride mid)
            (set! high mid))
          (set! low (add1 mid))))

    (vector-set! dp i (max (vector-ref dp (add1 i)) 
                          (+ earnings (vector-ref dp next-ride)))))

  (vector-ref dp 0))