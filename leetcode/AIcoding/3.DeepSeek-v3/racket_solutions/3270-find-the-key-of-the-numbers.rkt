(define (find-key nums)
  (let loop ([lst nums] [counts (hash)] [max-count 0] [result 0])
    (cond
      [(null? lst) result]
      [else
       (let* ([num (car lst)]
              [new-count (add1 (hash-ref counts num 0))]
              [new-counts (hash-set counts num new-count)]
              [new-max-count (max max-count new-count)]
              [new-result (if (> new-count max-count) num result)])
         (loop (cdr lst) new-counts new-max-count new-result))])))