(define (contains-cycle grid)
  (define rows (length grid))
  (define cols (length (car grid)))
  (define visited (make-vector rows (make-vector cols #f)))

  (define (dfs r c parent-r parent-c char)
    (vector-set! (vector-ref visited r) c #t)
    (define neighbors
      (filter
       (lambda (p)
         (and (>= (car p) 0) (< (car p) rows)
              (>= (cdr p) 0) (< (cdr p) cols)
              (equal? (vector-ref (vector-ref grid (car p)) (cdr p)) char)
              (not (and (equal? (car p) parent-r) (equal? (cdr p) parent-c))))
       (list (cons (- r 1) c) (cons (+ r 1) c)
             (cons r (- c 1)) (cons r (+ c 1)))))
    (for/or ([neighbor neighbors])
      (let ([nr (car neighbor)] [nc (cdr neighbor)])
        (if (vector-ref (vector-ref visited nr) nc)
            #t
            (dfs nr nc r c char)))))

  (for*/or ([r (range rows)] [c (range cols)])
    (if (not (vector-ref (vector-ref visited r) c))
        (dfs r c -1 -1 (vector-ref (vector-ref grid r) c))
        #f)))