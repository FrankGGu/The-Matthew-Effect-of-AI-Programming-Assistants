(define/contract (closest-nodes root queries)
  (-> (or/c null? (listof exact-integer?)) (listof exact-integer?) (listof (listof exact-integer?)))
  (define (inorder node)
    (if (null? node)
        '()
        (append (inorder (list-ref node 1)) (list (list-ref node 0)) (inorder (list-ref node 2)))))
  (define sorted-list (inorder root))
  (define (binary-search lst target)
    (let loop ([low 0]
               [high (sub1 (length lst))])
      (if (> low high)
          (cons (if (>= high 0) (list-ref lst high) -1)
                (if (< low (length lst)) (list-ref lst low) -1))
          (let ([mid (quotient (+ low high) 2)])
            (cond
              [(= (list-ref lst mid) target) (cons target target)]
              [(< (list-ref lst mid) target] (loop (add1 mid) high)]
              [else (loop low (sub1 mid))])))))
  (for/list ([q (in-list queries)])
    (let ([res (binary-search sorted-list q)])
      (if (equal? (car res) (cdr res))
          (list (car res) (car res))
          (list (car res) (cdr res))))))