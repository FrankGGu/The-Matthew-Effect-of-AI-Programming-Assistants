(define (get-biggest-three rhombus-grid)
  (define n (length rhombus-grid))
  (define m (length (car rhombus-grid)))
  (define rhombus-sums '())

  (define (get-rhombus-sum x y size)
    (define sum 0)
    (define k 0)
    (for* ([i (in-range size)]
           [j (in-range (- size 1) (+ size 1))])
      (define xi (+ x i))
      (define yj (+ y j))
      (when (and (>= xi 0) (< xi n) (>= yj 0) (< yj m))
        (set! sum (+ sum (list-ref (list-ref rhombus-grid xi) yj)))
        (when (= j (- size 1))
          (set! k (+ k 1)))))
    (when (= k size)
      sum))

  (for* ([i (in-range n)]
         [j (in-range m)]
         [size (in-range 1 (min (+ 1 (min i j)) (+ 1 (- n i)) (+ 1 (- m j))))])
    (let ([rhombus-sum (get-rhombus-sum i j size)])
      (when rhombus-sum
        (set! rhombus-sums (cons rhombus-sum rhombus-sums)))))

  (define unique-sums (remove-duplicates rhombus-sums))
  (define sorted-sums (sort unique-sums >))
  (take sorted-sums 3))

(define (list-to-grid lst)
  (map (lambda (x) (map (lambda (y) (string->number y)) (string-split x))) lst))

(define (main grid)
  (get-biggest-three (list-to-grid grid)))

(main (list "1 2 3" "4 5 6" "7 8 9"))