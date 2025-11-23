(define (unique-paths-iii grid)
  (let* ([rows (length grid)]
         [cols (length (first grid))]
         [start (let loop ([r 0] [c 0])
                    (cond [(>= r rows) #f]
                          [(>= c cols) (loop (+ r 1) 0)]
                          [(= (list-ref (list-ref grid r) c) 1) (list r c)]
                          [else (loop r (+ c 1))]))]
         [empty-cells (let loop ([r 0] [c 0] [count 0])
                          (cond [(>= r rows) count]
                                [(>= c cols) (loop (+ r 1) 0 count)]
                                [(= (list-ref (list-ref grid r) c) 0) (loop r (+ c 1) (+ count 1))]
                                [else (loop r (+ c 1) count)]))])
    (letrec ([dfs (lambda (r c visited)
                     (cond
                       [(or (< r 0) (>= r rows) (< c 0) (>= c cols) (member (list r c) visited) (= (list-ref (list-ref grid r) c) -1)) 0]
                       [(= (list-ref (list-ref grid r) c) 2) (if (= (length visited) (+ empty-cells 1)) 1 0)]
                       [else
                        (+ (dfs (+ r 1) c (cons (list r c) visited))
                           (dfs (- r 1) c (cons (list r c) visited))
                           (dfs r (+ c 1) (cons (list r c) visited))
                           (dfs r (- c 1) (cons (list r c) visited)))]))])
      (dfs (first start) (second start) (list start)))))