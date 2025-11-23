(define/contract (reconstruct-queue people)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)))
  (define sorted-people (sort people (lambda (a b) (or (> (car a) (car b)) (and (= (car a) (car b)) (< (cadr a) (cadr b))))
  (let loop ([lst sorted-people] [result '()])
    (if (null? lst)
        result
        (let* ([person (car lst)]
               [k (cadr person)]
               [left (take result k)]
               [right (drop result k)])
          (loop (cdr lst) (append left (list person) right)))))