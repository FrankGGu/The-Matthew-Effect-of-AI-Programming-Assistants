(define/contract (can-partition nums)
  (-> (listof exact-integer?) boolean?)
  (let* ([total (apply + nums)]
         [target (quotient total 2)])
    (if (odd? total)
        #f
        (let ([dp (make-hash)])
          (hash-set! dp 0 #t)
          (for ([num nums])
            (for ([i (in-range target (-1) (- num))])
              (when (hash-ref dp (- i num) #f)
                (hash-set! dp i #t))))
          (hash-ref dp target #f)))))