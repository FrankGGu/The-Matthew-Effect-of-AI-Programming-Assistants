(define (reductionOperations nums)
  (define sorted-nums (sort nums <))
  (define unique-nums (remove-duplicates sorted-nums))
  (define num-reductions (length unique-nums))
  (define total-reductions (if (= num-reductions 1) 0
                               (apply + (map (lambda (x) (- num-reductions (index-of unique-nums x)))
                                             unique-nums))))
  total-reductions))

(define (index-of lst elem)
  (for/fold ((i 0)) ((x lst) (i i))
    (if (= x elem) (begin (set! i (+ i 1)) i) (set! i (+ i 1)))))

(define (remove-duplicates lst)
  (foldl (lambda (x acc)
            (if (member x acc) acc (cons x acc)))
          '() lst))

(define (sort lst cmp)
  (if (null? lst) '()
      (cons (car lst) (sort (filter (lambda (x) (cmp x (car lst))) (cdr lst)) cmp)))))