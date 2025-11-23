(define (find-beautiful-indices nums)
  (define n (length nums))
  (define (is-beautiful i)
    (and (<= 0 i) (< i n) 
         (or (= i 0) (> (list-ref nums i) (list-ref nums (- i 1))))
         (or (= i (- n 1)) (< (list-ref nums i) (list-ref nums (+ i 1))))))
  (for/list ([i (in-range n)] 
              #:when (is-beautiful i))
    i))

(find-beautiful-indices '(1 3 2 4 5))