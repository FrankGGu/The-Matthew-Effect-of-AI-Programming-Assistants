(define (has-path? maze start destination)
  (define rows (length maze))
  (define cols (length (car maze)))
  (define visited (make-mutable-vector (* rows cols) #f))

  (define (valid-move? r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols) (= (list-ref (list-ref maze r) c) 0)))

  (define (index r c)
    (+ (* r cols) c))

  (define (dfs r c)
    (cond
      [(vector-ref visited (index r c)) #f]
      [(= r (car destination)) (= c (cadr destination)) #t]
      [else
       (vector-set! visited (index r c) #t)

       (let loop ([r-new r] [c-new c])
         (cond
           [(or (< r-new 0) (>= r-new rows) (< c-new 0) (>= c-new cols) (= (list-ref (list-ref maze r-new) c-new) 1))
            (if (and (dfs r (add1 c))) #t
                (let loop ([r-new r] [c-new c])
                  (cond
                    [(or (< r-new 0) (>= r-new rows) (< c-new 0) (>= c-new cols) (= (list-ref (list-ref maze r-new) c-new) 1))
                     (if (and (dfs (add1 r) c)) #t
                         (let loop ([r-new r] [c-new c])
                           (cond
                             [(or (< r-new 0) (>= r-new rows) (< c-new 0) (>= c-new cols) (= (list-ref (list-ref maze r-new) c-new) 1))
                              (if (and (dfs r (sub1 c))) #t
                                  (let loop ([r-new r] [c-new c])
                                    (cond
                                      [(or (< r-new 0) (>= r-new rows) (< c-new 0) (>= c-new cols) (= (list-ref (list-ref maze r-new) c-new) 1))
                                       #f]
                                      [else
                                       (loop (sub1 r-new) c-new)])))]
                             [else
                              (loop r-new (add1 c-new))])))]
                     [else
                      (loop (add1 r-new) c-new))])))]
           [else
            (loop r-new (add1 c-new))])))]))

  (dfs (car start) (cadr start)))