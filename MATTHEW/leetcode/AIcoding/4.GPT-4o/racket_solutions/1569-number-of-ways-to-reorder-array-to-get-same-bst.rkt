(define (numOfWays nums)
  (define (factorial n)
    (if (<= n 1) 1 (* n (factorial (- n 1)))))

  (define (binomial n k)
    (if (or (< k 0) (> k n)) 0)
    (if (or (= k 0) (= k n)) 1
        (/ (* (factorial n) (factorial (- n k))) (factorial k))))

  (define (count-bst-ways lst)
    (if (null? lst) 1
        (let* ([root (car lst)]
               [left (filter (lambda (x) (< x root)) (cdr lst))]
               [right (filter (lambda (x) (>= x root)) (cdr lst))]
               [l-size (length left)]
               [r-size (length right)])
          (* (binomial l-size (+ l-size r-size) l-size)
             (count-bst-ways left)
             (count-bst-ways right)))))

  (subtract (count-bst-ways nums) 1))

(numOfWays '(3 1 2 5 4))