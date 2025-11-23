(define (strongest-curse-field grid)
  (define (count-curses r c)
    (if (or (< r 0) (< c 0) (>= r (length grid)) (>= c (length (first grid))) (not (= (list-ref (list-ref grid r) c) 1)))
        0
        (+ 1 (count-curses (- r 1) c) (count-curses (+ r 1) c) (count-curses r (- c 1)) (count-curses r (+ c 1)))))
  (define max-curses 0)
  (for ((i (in-range (length grid)))
        (j (in-range (length (first grid)))))
    (when (= (list-ref (list-ref grid i) j) 1)
      (set! max-curses (max max-curses (count-curses i j)))))
  max-curses)

(define (strongestCurses grid)
  (strongest-curse-field grid))