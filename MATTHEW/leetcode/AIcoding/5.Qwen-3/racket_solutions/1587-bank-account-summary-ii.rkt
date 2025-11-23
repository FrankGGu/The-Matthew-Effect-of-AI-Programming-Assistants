#lang racket

(define (account-summary-ii accounts-table)
  (define (parse-account s)
    (let* ([parts (string-split s #\space)]
           [name (car parts)]
           [balance (string->number (caddr parts))])
      (cons name balance)))

  (define (merge-balances accs)
    (for/fold ([result '()])
              ([acc (in-list accs)])
      (let ([name (car acc)]
            [balance (cdr acc)])
        (if (null? result)
            (list acc)
            (let ([existing (assoc name result)])
              (if existing
                  (let ([new-balance (+ (cdr existing) balance)])
                    (append (remove existing result) (list (cons name new-balance))))
                  (append result (list acc))))))))

  (define (sort-result result)
    (sort result (lambda (a b) (< (cdr a) (cdr b)))))

  (define parsed (map parse-account accounts-table))
  (define merged (merge-balances parsed))
  (define sorted (sort-result merged))
  (map (lambda (x) (list (car x) (cdr x))) sorted))