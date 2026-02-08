(define (ways-to-cut-pizza pizza k)
  (define rows (length pizza))
  (define cols (length (first pizza)))

  (define prefix-sums (make-vector (+ 1 rows) (make-vector (+ 1 cols) 0)))
  (for ([i (in-range rows)]
        [j (in-range cols)])
    (vector-set! prefix-sums (+ 1 i) (+ 1 (+ (vector-ref prefix-sums i j) (if (= (char->integer (string-ref (vector-ref pizza i) j)) #\P) 1 0)))))
    (for ([x (in-range (+ 1 i) (+ 1 rows))])
      (for ([y (in-range (+ 1 j) (+ 1 cols))])
        (vector-set! prefix-sums x y (+ (vector-ref prefix-sums x y) (if (and (= x (+ 1 i)) (= y (+ 1 j))) 0 (if (= (char->integer (string-ref (vector-ref pizza x) y)) #\P) 1 0)))))))

  (define (count-ways i j cuts)
    (if (= cuts 0)
        (if (> (vector-ref prefix-sums (+ 1 i) (+ 1 j)) 0) 1 0)
        (apply + (for/list ([x (in-range (+ 1 i) rows)])
                   (if (> (vector-ref prefix-sums (+ 1 x) (+ 1 j)) 0)
                       (count-ways x j (- cuts 1))
                       0))
              (for/list ([y (in-range (+ 1 j) cols)])
                   (if (> (vector-ref prefix-sums (+ 1 i) (+ 1 y)) 0)
                       (count-ways i y (- cuts 1))
                       0)))))

  (count-ways 0 0 (- k 1)))

(define (waysToCutPizza pizza k)
  (ways-to-cut-pizza pizza k))