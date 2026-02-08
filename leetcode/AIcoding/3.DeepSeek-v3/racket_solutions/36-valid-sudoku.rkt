(define/contract (is-valid-sudoku board)
  (-> (listof (listof char?)) boolean?)
  (define (valid? lst)
    (let ([seen (make-hash)])
      (for/and ([c (in-list lst)])
        (if (char=? c #\.)
            #t
            (if (hash-has-key? seen c)
                #f
                (begin (hash-set! seen c #t) #t)))))
  (and
   (for/and ([row (in-list board)])
     (valid? row))
   (for/and ([col (in-range 9)])
     (valid? (for/list ([row (in-list board)]) (list-ref row col))))
   (for/and ([box-row (in-range 0 9 3)])
     (for/and ([box-col (in-range 0 9 3)])
       (valid?
        (append*
         (for/list ([i (in-range 3)])
           (for/list ([j (in-range 3)])
             (list-ref (list-ref board (+ box-row i)) (+ box-col j))))))))