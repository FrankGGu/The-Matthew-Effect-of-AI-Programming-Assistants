#lang racket

(define (countSmaller nums)
  (define (merge-and-count left right)
    (let loop ((l left) (r right) (count 0) (result '()))
      (cond
        [(null? l) (append result (map (lambda (x) (+ count 0)) r))]
        [(null? r) (append result (map (lambda (x) (+ count 0)) l))]
        [(< (car l) (car r))
         (loop (cdr l) r (+ count (length r)) (cons (car l) result))]
        [else
         (loop l (cdr r) count (cons (car r) result))])))

  (define (sort-with-count arr)
    (if (<= (length arr) 1)
        (list arr '())
        (let* ((mid (quotient (length arr) 2))
               (left (sort-with-count (sublist arr 0 mid)))
               (right (sort-with-count (sublist arr mid)))
               (sorted (merge-and-count (car left) (car right)))
               (count-left (cadr left))
               (count-right (cadr right)))
          (values (reverse sorted) (append count-left count-right)))))

  (define (count-smaller-helper arr)
    (let-values ([(sorted counts) (sort-with-count (map list (reverse nums)))])
      (reverse counts)))

  (count-smaller-helper nums))

(countSmaller '(5 2 6 1))