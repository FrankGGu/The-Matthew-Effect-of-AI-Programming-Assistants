(define/contract (manhattan-distances grid)
  (-> (listof (listof exact-integer?)) (listof exact-integer?))
  (define (dist r1 c1 r2 c2)
    (+ (abs (- r1 r2)) (abs (- c1 c2))))

  (let* ([rows (length grid)]
         [cols (if (null? grid) 0 (length (car grid)))]
         [pieces (for*/list ([i (in-range rows)]
                             [j (in-range cols)]
                             #:when (positive? (list-ref (list-ref grid i) j)))
                   (cons i j))])
    (if (<= (length pieces) 1)
        '()
        (let ([perms (permutations pieces)])
          (for/list ([perm perms])
            (let loop ([lst perm] [sum 0])
              (if (null? (cdr lst))
                  sum
                  (loop (cdr lst) (+ sum (dist (caar lst) (cdar lst) (caadr lst) (cdadr lst)))))))))))