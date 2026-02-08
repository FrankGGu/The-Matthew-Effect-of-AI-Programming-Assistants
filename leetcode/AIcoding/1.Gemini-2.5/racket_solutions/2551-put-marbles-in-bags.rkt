(define (put-marbles weights k)
  (let* ([n (length weights)]
         [k-1 (- k 1)])
    (if (= k 1)
        0
        (let* ([pairs-sum
                (let loop ([lst weights] [acc '()])
                  (if (or (null? lst) (null? (cdr lst)))
                      (reverse acc)
                      (loop (cdr lst) (cons (+ (car lst) (cadr lst)) acc))))]
               [sorted-pairs-sum (sort pairs-sum <)]
               [min-k-1-sums (take sorted-pairs-sum k-1)]
               [max-k-1-sums (take-right sorted-pairs-sum k-1)])
          (- (apply + max-k-1-sums)
             (apply + min-k-1-sums))))))