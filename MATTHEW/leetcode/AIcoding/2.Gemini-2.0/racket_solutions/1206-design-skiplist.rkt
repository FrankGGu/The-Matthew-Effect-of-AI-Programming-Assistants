(define skiplist%
  (class object%
    (init-field (max-level 16) (p 0.5))
    (define head (vector #f))
    (define level 0)

    (define/public (initialize)
      (set! head (make-vector (add1 max-level) #f))
      (set! level 0))

    (define (random-level)
      (let loop ([l 1])
        (if (and (< l max-level) (< (random) p))
            (loop (add1 l))
            l)))

    (define (update val)
      (let ([update-arr (make-vector (add1 max-level) #f)])
        (let loop ([i level])
          (if (negative? i)
              update-arr
              (let loop2 ([node head])
                (cond
                  [(or (not (vector-ref node i)) (> (car (vector-ref node i)) val))
                   (vector-set! update-arr i node)
                   (loop (sub1 i))]
                  [(< (car (vector-ref node i)) val)
                   (loop2 (vector-ref node i))]
                  [else
                   (vector-set! update-arr i node)
                   (loop (sub1 i))]))))))

    (define/public (search target)
      (let loop ([i level] [node head])
        (cond
          [(negative? i) #f]
          [else
           (let loop2 ([curr node])
             (cond
               [(not (vector-ref curr i)) (loop (sub1 i) curr)]
               [(< (car (vector-ref (vector-ref curr i) 0)) target)
                (loop2 (vector-ref curr i))]
               [(= (car (vector-ref (vector-ref curr i) 0)) target) #t]
               [else (loop (sub1 i) curr)]))])))

    (define/public (add num)
      (let ([new-level (random-level)])
        (if (> new-level level)
            (begin
              (for ([i (in-range (add1 level) (add1 new-level))])
                (vector-set! head i #f))
              (set! level new-level)))
        (let ([update-arr (update num)]
              [new-node (make-vector (add1 new-level) #f)])
          (vector-set! new-node 0 num)
          (for ([i (in-range new-level)])
            (let ([next (vector-ref (vector-ref update-arr i) i)])
              (vector-set! new-node i next)
              (vector-set! (vector-ref update-arr i) i new-node))))))

    (define/public (erase num)
      (let ([update-arr (update num)])
        (if (not (vector-ref (vector-ref update-arr 0) 0))
            #f
            (if (= (car (vector-ref (vector-ref (vector-ref update-arr 0) 0) 0)) num)
                (begin
                  (for ([i (in-range (add1 level))])
                    (if (vector-ref (vector-ref update-arr i) i)
                        (if (= (car (vector-ref (vector-ref (vector-ref update-arr i) i) 0)) num)
                            (vector-set! (vector-ref update-arr i) i (vector-ref (vector-ref (vector-ref update-arr i) i) i))
                            #f)
                        #f))
                  (while (and (> level 0) (not (vector-ref head level)))
                         (set! level (sub1 level)))
                  #t)
                #f)))))
    (super-new)))