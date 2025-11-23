(define (number-of-ways people)
  (define sorted-people (sort people (lambda (p1 p2) (or (< (first p1) (first p2)) (and (= (first p1) (first p2)) (< (second p1) (second p2)))))))
  (define (count-ways current-index placed)
    (cond
      [(>= current-index (length sorted-people)) 1]
      [else
       (let* ([person (list-ref sorted-people current-index)]
              [can-place (not (ormap (lambda (p) (and (<= (first p) (first person)) (<= (second person) (second p)))) placed))])
         (+ (count-ways (+ current-index 1) placed)
            (if can-place (count-ways (+ current-index 1) (cons person placed)) 0))))])
  (count-ways 0 '()))