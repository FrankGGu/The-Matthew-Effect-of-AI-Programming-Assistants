(define (minFlips a)
  (define m (length a))
  (define n (length (car a)))

  (define (to-num mat)
    (foldl (lambda (row acc)
             (+ (* acc 2) (foldl (lambda (x acc2) (+ (* acc2 2) x)) 0 row)))
           0 mat))

  (define (to-mat num)
    (let loop ([num num] [mat '()])
      (if (null? mat)
          (let loop2 ([i 0] [row '()])
            (if (= i n)
                (loop (+ 0 num) (cons (reverse row) mat))
                (let ([bit (modulo num 2)])
                  (loop2 (+ 1 i) (cons bit row) (quotient num 2)))))
          (if (= (length mat) m)
              (reverse mat)
              (let loop2 ([i 0] [row '()])
                (if (= i n)
                    (loop (+ 0 num) (cons (reverse row) mat))
                    (let ([bit (modulo num 2)])
                      (loop2 (+ 1 i) (cons bit row) (quotient num 2)))))))))

  (define (flip-cell mat r c)
    (map (lambda (i row)
           (map (lambda (j x)
                  (if (and (= i r) (= j c)) (if (= x 0) 1 0) x))
                (range n)
                row))
         (range m)
         mat))

  (define (flip-neighbors mat r c)
    (let ([new-mat (flip-cell mat r c)])
      (cond
        [(and (> r 0)) (set! new-mat (flip-cell new-mat (- r 1) c))]
        [else #f])
      (cond
        [(and (< r (- m 1))) (set! new-mat (flip-cell new-mat (+ r 1) c))]
        [else #f])
      (cond
        [(and (> c 0)) (set! new-mat (flip-cell new-mat r (- c 1)))]
        [else #f])
      (cond
        [(and (< c (- n 1))) (set! new-mat (flip-cell new-mat r (+ c 1)))]
        [else #f])
      new-mat))

  (define (neighbors mat)
    (apply append (map (lambda (r)
                         (map (lambda (c)
                                (flip-neighbors mat r c))
                              (range n)))
                       (range m))))

  (define target 0)
  (define start (to-num a))
  (define q (list (cons start 0)))
  (define visited (set start))

  (let loop ([q q])
    (cond
      [(null? q) -1]
      [else
       (let ([curr (car q)] [new-q (cdr q)])
         (let ([node (car curr)] [dist (cdr curr)])
           (if (= node target)
               dist
               (let ([next-nodes (map to-num (neighbors (to-mat node)))])
                 (let ([unvisited-neighbors (filter (lambda (x) (not (set-member? visited x))) next-nodes)])
                   (let ([new-visited (set-union visited (list->set unvisited-neighbors))])
                     (loop (append new-q (map (lambda (x) (cons x (+ dist 1))) unvisited-neighbors)))))))))])))