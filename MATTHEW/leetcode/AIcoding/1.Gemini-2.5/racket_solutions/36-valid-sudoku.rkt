(define (is-valid-sudoku board)
  (define (has-duplicates? items)
    (let* ([digits (filter (lambda (c) (char-numeric? c)) items)]
           [digit-set (list->set digits)])
      (not (= (length digits) (set-count digit-set)))))

  (and
   ;; Check rows
   (for/and ([row board])
     (not (has-duplicates? row)))

   ;; Check columns
   (for/and ([col-idx (in-range 9)])
     (let ([column (build-list 9 (lambda (row-idx)
                                   (list-ref (list-ref board row-idx) col-idx)))])
       (not (has-duplicates? column))))

   ;; Check 3x3 sub-boxes
   (for/and ([block-row-start (in-range 0 9 3)])
     (for/and ([block-col-start (in-range 0 9 3)])
       (let ([box-elements (build-list 9 (lambda (k)
                                           (let* ([r (+ block-row-start (quotient k 3))]
                                                  [c (+ block-col-start (remainder k 3))])
                                             (list-ref (list-ref board r) c))))])
         (not (has-duplicates? box-elements)))))))