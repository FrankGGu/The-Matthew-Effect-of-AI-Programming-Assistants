(define (find-category-recommendation-pairs categories)
  (let* ((category-map (make-hash))
         (result (make-hash)))
    (for ([i (in-range (length categories))])
      (let* ([user (list-ref categories i)]
             (categories-set (set->list (list->set user))))
        (for ([cat1 (in-list categories-set)])
          (for ([cat2 (in-list categories-set)])
            (when (not (equal? cat1 cat2))
              (let* ([key (if (string<? cat1 cat2) (cons cat1 cat2) (cons cat2 cat1))])
                (hash-update! result key (lambda (val) (+ val 1)) 1)))))))
    (let* ((result-list (list))
           (keys (hash-keys result)))
      (for ([key (in-list keys)])
        (let* ([count (hash-ref result key)]
               [cat1 (car key)]
               [cat2 (cdr key)])
          (set! result-list (cons (list cat1 cat2 count) result-list))))
      (sort result-list (lambda (x y)
                            (cond
                              [(> (list-ref x 2) (list-ref y 2)) #t]
                              [(= (list-ref x 2) (list-ref y 2))
                               (cond
                                 [(string<? (list-ref x 0) (list-ref y 0)) #t]
                                 [(= (list-ref x 0) (list-ref y 0))
                                  (string<? (list-ref x 1) (list-ref y 1))]
                                 [else #f])]
                              [else #f])))))))