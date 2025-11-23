(define (num-moves-until-possible a b c)
  (let* ((sorted (sort (list a b c) <))
         (x (first sorted))
         (y (second sorted))
         (z (third sorted)))
    (if (and (= (- y x) 1) (= (- z y) 1))
        0
        (if (<= (- z x) 2)
            2
            (if (or (= (- y x) 1) (= (- z y) 1))
                1
                2)))))

(define (moving-stones-until-consecutive a b c)
  (num-moves-until-possible a b c))