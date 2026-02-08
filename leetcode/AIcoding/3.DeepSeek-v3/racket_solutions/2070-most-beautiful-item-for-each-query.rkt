(define/contract (maximum-beauty items queries)
  (-> (listof (listof exact-integer?)) (listof exact-integer?) (listof exact-integer?))
  (define sorted-items (sort items (lambda (a b) (< (first a) (first b)))))
  (define max-beauty-so-far 0)
  (define max-beauty-list (make-list (length sorted-items) 0))
  (for ([i (in-range (length sorted-items))])
    (set! max-beauty-so-far (max max-beauty-so-far (second (list-ref sorted-items i))))
    (list-set! max-beauty-list i max-beauty-so-far))
  (define price-list (map first sorted-items))
  (define (binary-search target)
    (let loop ([left 0] [right (sub1 (length price-list))])
      (if (> left right)
          right
          (let* ([mid (quotient (+ left right) 2)]
                 [mid-val (list-ref price-list mid)])
            (cond
              [(= mid-val target) mid]
              [(< mid-val target) (loop (add1 mid) right)]
              [else (loop left (sub1 mid))])))))
  (define result '())
  (for ([q (in-list queries)])
    (define idx (binary-search q))
    (if (>= idx 0)
        (set! result (cons (list-ref max-beauty-list idx) result))
        (set! result (cons 0 result))))
  (reverse result))