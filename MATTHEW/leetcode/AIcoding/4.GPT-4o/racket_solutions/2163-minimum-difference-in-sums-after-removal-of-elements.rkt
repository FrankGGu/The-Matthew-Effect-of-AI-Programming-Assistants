(define (minimumDifference nums)
  (define n (length nums))
  (define half (/ n 2))
  (define left-sums (list))
  (define right-sums (list))

  (define (generate-sums lst)
    (define (helper lst k)
      (if (= k 0)
          (list 0)
          (if (null? lst)
              '()
              (let* ((first (car lst))
                     (rest (cdr lst))
                     (with-first (map (lambda (x) (+ x first)) (helper rest (- k 1))))
                     (without-first (helper rest k)))
                (append without-first with-first)))))

    (for ((k (in-range 0 (add1 half))))
      (set! left-sums (append left-sums (helper lst k))))

    (for ((k (in-range 0 (add1 (- n half)))))
      (set! right-sums (append right-sums (helper lst k))))

    (define total-sum (apply + nums))
    (define min-diff (apply min (map (lambda (x) (abs (- (* 2 x) total-sum))) left-sums)))

    min-diff))

(minimumDifference '(3 9 7 3))