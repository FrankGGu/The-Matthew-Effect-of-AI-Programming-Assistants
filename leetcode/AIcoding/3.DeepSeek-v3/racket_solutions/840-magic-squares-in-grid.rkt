(define/contract (num-magic-squares-inside grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define (is-magic-square? r c)
    (if (and (<= r (- (length grid) 2))
             (<= c (- (length (list-ref grid 0)) 2)))
        (let* ([a (list-ref (list-ref grid r) c)]
               [b (list-ref (list-ref grid r) (+ c 1))]
               [c1 (list-ref (list-ref grid r) (+ c 2))]
               [d (list-ref (list-ref grid (+ r 1)) c)]
               [e (list-ref (list-ref grid (+ r 1)) (+ c 1))]
               [f (list-ref (list-ref grid (+ r 1)) (+ c 2))]
               [g (list-ref (list-ref grid (+ r 2)) c)]
               [h (list-ref (list-ref grid (+ r 2)) (+ c 1))]
               [i (list-ref (list-ref grid (+ r 2)) (+ c 2))])
          (and (distinct? (list a b c1 d e f g h i))
               (and (<= 1 a 9) (<= 1 b 9) (<= 1 c1 9)
               (<= 1 d 9) (<= 1 e 9) (<= 1 f 9)
               (<= 1 g 9) (<= 1 h 9) (<= 1 i 9))
               (= (+ a b c1) (+ d e f) (+ g h i) (+ a d g) (+ b e h) (+ c1 f i) (+ a e i) (+ c1 e g))))
        #f))
  (define (distinct? lst)
    (= (length lst) (length (remove-duplicates lst))))
  (let ([rows (length grid)]
        [cols (if (null? grid) 0 (length (car grid)))])
    (let loop ([r 0] [c 0] [count 0])
      (cond
        [(>= r rows) count]
        [(>= c cols) (loop (+ r 1) 0 count)]
        [(is-magic-square? r c) (loop r (+ c 1) (+ count 1))]
        [else (loop r (+ c 1) count)]))))