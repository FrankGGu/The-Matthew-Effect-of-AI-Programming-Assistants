(define (shortest-path grid k)
  (define m (length grid))
  (define n (length (first grid)))
  (define visited (make-hash))

  (define (valid? r c)
    (and (>= r 0) (< r m) (>= c 0) (< c n)))

  (define (bfs)
    (let ([q (make-queue)])
      (queue-enqueue! q (list 0 0 k 0)) ; r, c, remaining eliminations, path length
      (hash-set! visited (list 0 0 k) #t)

      (define (process-neighbors r c elim path-len)
        (define directions '((0 1) (0 -1) (1 0) (-1 0)))
        (for-each (lambda (dir)
                    (let* ([new-r (+ r (first dir))]
                           [new-c (+ c (second dir))])
                      (cond
                        [(and (valid? new-r new-c) (= (list new-r new-c) (list (- m 1) (- n 1))))
                         (+ path-len 1)]
                        [(and (valid? new-r new-c) (= (list new-r new-c) (list r c)))
                         #f]
                        [(and (valid? new-r new-c) (= (list r c) (list (- m 1) (- n 1))))
                         #f]
                        [(and (valid? new-r new-c) (= (list new-r new-c) (list r c)))
                         #f]
                        [(and (valid? new-r new-c) (= (list r c) (list (- m 1) (- n 1))))
                         #f]
                        [(and (valid? new-r new-c) (= (list new-r new-c) (list r c)))
                         #f]
                        [(and (valid? new-r new-c) (= (list r c) (list (- m 1) (- n 1))))
                         #f]
                        [(and (valid? new-r new-c) (zero? (list r c)) (= (list (- m 1) (- n 1)) (list 0 0)))
                         #f]
                        [(and (valid? new-r new-c) (= (list new-r new-c) (list 0 0)) (= (list (- m 1) (- n 1)) (list 0 0)))
                         #f]
                        [(and (valid? new-r new-c) (= (list r c) (list 0 0)) (= (list (- m 1) (- n 1)) (list 0 0)))
                         #f]
                        [(and (valid? new-r new-c) (zero? (list r c)) (= (list (- m 1) (- n 1)) (list 0 0)))
                         #f]
                        [(and (valid? new-r new-c) (= (list new-r new-c) (list 0 0)) (= (list (- m 1) (- n 1)) (list 0 0)))
                         #f]
                        [(and (valid? new-r new-c) (= (list r c) (list 0 0)) (= (list (- m 1) (- n 1)) (list 0 0)))
                         #f]
                        [(and (valid? new-r new-c) (= (list new-r new-c) (list (- m 1) (- n 1))))
                         (return (+ path-len 1))]
                        [else
                         (let ([new-elim (if (= (list-ref (list-ref grid new-r) new-c) 1) (- elim 1) elim)])
                           (cond
                             [(and (>= new-elim 0) (not (hash-has-key? visited (list new-r new-c new-elim))))
                              (queue-enqueue! q (list new-r new-c new-elim (+ path-len 1)))
                              (hash-set! visited (list new-r new-c new-elim) #t)]
                             [else #f]))])))))
        directions))

      (let loop ()
        (cond
          [(queue-empty? q) -1]
          [else
           (let ([curr (queue-dequeue! q)])
             (let ([r (list-ref curr 0)]
                   [c (list-ref curr 1)]
                   [elim (list-ref curr 2)]
                   [path-len (list-ref curr 3)])
               (cond
                 [(= r (- m 1))
                  (if (= c (- n 1))
                      path-len
                      (process-neighbors r c elim path-len)
                      (loop))]
                 [else
                  (process-neighbors r c elim path-len)
                  (loop)]))))]))))

  (bfs))