(define/contract (count-smaller nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (define n (length nums))
  (define result (make-vector n 0))
  (define indexed-nums (for/list ([num nums] [i (in-naturals)]) (cons num i)))

  (define (merge-sort lst)
    (if (<= (length lst) 1)
        lst
        (let* ([mid (quotient (length lst) 2)]
               [left (merge-sort (take lst mid))]
               [right (merge-sort (drop lst mid))])
          (merge left right))))

  (define (merge left right)
    (let loop ([left left] [right right] [merged '()] [right-count 0])
      (cond
        [(empty? left) (append (reverse merged) right)]
        [(empty? right) 
         (for ([pair left])
           (let ([idx (cdr pair)])
             (vector-set! result idx (+ (vector-ref result idx) right-count))))
         (append (reverse merged) left)]
        [else
         (let ([l (car left)]
               [r (car right)])
           (if (<= (car l) (car r))
               (begin
                 (vector-set! result (cdr l) (+ (vector-ref result (cdr l)) right-count))
                 (loop (cdr left) right (cons l merged) right-count))
               (loop left (cdr right) (cons r merged) (+ right-count 1))))])))

  (merge-sort indexed-nums)
  (vector->list result))