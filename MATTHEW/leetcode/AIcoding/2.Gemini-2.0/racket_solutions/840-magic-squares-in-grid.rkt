(define (magic-square? grid row col)
  (define (get-val r c)
    (list-ref (list-ref grid r) c))
  (define (sum-row r)
    (+ (get-val r col) (get-val r (+ col 1)) (get-val r (+ col 2))))
  (define (sum-col c)
    (+ (get-val row c) (get-val (+ row 1) c) (get-val (+ row 2) c)))
  (define (sum-diag1)
    (+ (get-val row col) (get-val (+ row 1) (+ col 1)) (get-val (+ row 2) (+ col 2))))
  (define (sum-diag2)
    (+ (get-val row (+ col 2)) (get-val (+ row 1) (+ col 1)) (get-val (+ row 2) col)))
  (define (valid-nums?)
    (let loop ([nums '()] [r row] [c col])
      (cond
        [(> r (+ row 2)) #t]
        [(> c (+ col 2)) (loop nums (+ r 1) col)]
        [else
         (let ([num (get-val r c)])
           (cond
             [(or (< num 1) (> num 9) (member num nums)) #f]
             [else (loop (cons num nums) r (+ c 1))]))])))

  (if (not (valid-nums?))
      #f
      (let ([target (sum-row row)])
        (and (= target (sum-row (+ row 1)))
             (= target (sum-row (+ row 2)))
             (= target (sum-col col))
             (= target (sum-col (+ col 1)))
             (= target (sum-col (+ col 2)))
             (= target (sum-diag1))
             (= target (sum-diag2))))))

(define (num-magic-squares-inside grid)
  (define rows (length grid))
  (define cols (length (list-ref grid 0)))
  (define (loop row col count)
    (cond
      [(>= row (- rows 2)) count]
      [(>= col (- cols 2)) (loop (+ row 1) 0 count)]
      [else
       (if (magic-square? grid row col)
           (loop row (+ col 1) (+ count 1))
           (loop row (+ col 1) count))]))
  (loop 0 0 0))