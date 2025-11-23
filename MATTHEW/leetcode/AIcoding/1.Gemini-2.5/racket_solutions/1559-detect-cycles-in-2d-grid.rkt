(define (contains-cycle grid)
  (define rows (vector-length grid))
  (define cols (vector-length (vector-ref grid 0)))

  (define visited (make-vector rows))
  (for ([i (in-range rows)])
    (vector-set! visited i (make-vector cols #f)))

  (define (valid-coords r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define (dfs r c pr pc char-to-match)
    (vector-set! (vector-ref visited r) c #t)

    (define drs '(-1 1 0 0))
    (define dcs '(0 0 -1 1))

    (for ([i (in-range 4)])
      (define nr (+ r (list-ref drs i)))
      (define nc (+ c (list-ref dcs i)))

      (when (valid-coords nr nc)
        (when (and (char=? (vector-ref (vector-ref grid nr) nc) char-to-match)
                   (not (and (= nr pr) (= nc pc))))
          (cond
            ((vector-ref (vector-ref visited nr) nc)
             (call/cc (lambda (k) (k #t))))
            (else
             (when (dfs nr nc r c char-to-match)
               (call/cc (lambda (k) (k #t)))))))))
    #f)

  (call/cc
   (lambda (return-from-main)
     (for ([r (in-range rows)])
       (for ([c (in-range cols)])
         (unless (vector-ref (vector-ref visited r) c)
           (when (dfs r c -1 -1 (vector-ref (vector-ref grid r) c))
             (return-from-main #t)))))
     #f)))