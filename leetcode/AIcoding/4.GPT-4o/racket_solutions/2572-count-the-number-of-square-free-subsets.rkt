(define (square-free-subsets nums)
  (define (is-square-free n)
    (define (count-squares n)
      (let loop ((i 2) (count 0))
        (if (> (* i i) n)
            count
            (if (= (modulo n (* i i)) 0)
                (loop (+ i 1) (+ count 1))
                (loop (+ i 1) count)))))
    (= (count-squares n) 0))

  (define (count-subsets lst)
    (if (null? lst)
        1
        (let ((first (car lst))
              (rest (cdr lst)))
          (if (is-square-free first)
              (+ (count-subsets rest)
                 (count-subsets rest))
              (count-subsets rest)))))

  (count-subsets nums))

(square-free-subsets '(1 2 3 4 5))