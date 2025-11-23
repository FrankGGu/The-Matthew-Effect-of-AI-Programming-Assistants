(define/contract (color-border grid row col color)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer? exact-integer? (listof (listof exact-integer?)))
  (let* ([m (length grid)]
         [n (length (car grid))]
         [original-color (list-ref (list-ref grid row) col)]
         [visited (make-hash)]
         [directions '((-1 0) (1 0) (0 -1) (0 1))])
    (define (is-border? r c)
      (or (= r 0) (= r (sub1 m)) (= c 0) (= c (sub1 n))
          (ormap (lambda (dir)
                   (let ([nr (+ r (car dir))]
                         [nc (+ c (cadr dir))])
                     (and (>= nr 0) (< nr m) (>= nc 0) (< nc n)
                          (not (= (list-ref (list-ref grid nr) nc) original-color)))))
                 directions)))
    (define (dfs r c)
      (let ([key (cons r c)])
        (when (and (not (hash-has-key? visited key))
                   (>= r 0) (< r m) (>= c 0) (< c n)
                   (= (list-ref (list-ref grid r) c) original-color))
          (hash-set! visited key #t)
          (when (is-border? r c)
                (hash-set! visited (cons r c) 'border))
          (for-each (lambda (dir)
                      (let ([nr (+ r (car dir))]
                            [nc (+ c (cadr dir))])
                        (dfs nr nc)))
                    directions))))
    (dfs row col)
    (for/list ([i (in-range m)])
      (for/list ([j (in-range n)])
        (if (and (hash-has-key? visited (cons i j)) 
            (if (eq? (hash-ref visited (cons i j)) 'border)
                color
                (list-ref (list-ref grid i) j))
            (list-ref (list-ref grid i) j)))))