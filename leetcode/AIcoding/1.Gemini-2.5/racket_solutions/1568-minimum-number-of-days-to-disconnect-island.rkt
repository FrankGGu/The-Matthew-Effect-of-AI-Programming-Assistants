(define (min-days grid)
  (define rows (length grid))
  (define cols (length (car grid)))

  (define (is-valid r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define dr '(-1 1 0 0))
  (define dc '(0 0 -1 1))

  (define (dfs current-r current-c current-grid visited-set)
    (define new-visited-set (set-add visited-set (list current-r current-c)))
    (for ([i (in-range 4)])
      (define next-r (+ current-r (list-ref dr i)))
      (define next-c (+ current-c (list-ref dc i)))
      (when (and (is-valid next-r next-c)
                 (= (list-ref (list-ref current-grid next-r) next-c) 1)
                 (not (set-member? new-visited-set (list next-r next-c))))
        (set! new-visited-set (dfs next-r next-c current-grid new-visited-set))))
    new-visited-set)

  (define (count-components current-grid)
    (define num-components 0)
    (define visited (set))

    (for ([r (in-range rows)])
      (for ([c (in-range cols)])
        (when (and (= (list-ref (list-ref current-grid r) c) 1)
                   (not (set-member? visited (list r c))))
          (set! num-components (+ num-components 1))
          (set! visited (dfs r c current-grid visited)))))
    num-components)

  (define initial-components (count-components grid))

  (if (not (= initial-components 1))
      0
      (call-with-current-continuation
       (lambda (return)
         (for ([r (in-range rows)])
           (for ([c (in-range cols)])
             (when (= (list-ref (list-ref grid r) c) 1)
               (define new-grid
                 (for/list ([row-list grid] [row-idx (in-naturals)])
                   (if (= row-idx r)
                       (for/list ([val row-list] [col-idx (in-naturals)])
                         (if (= col-idx c) 0 val))
                       row-list)))
               (define components-after-one-day (count-components new-grid))
               (when (not (= components-after-one-day 1))
                 (return 1))))))
         2)))
  )