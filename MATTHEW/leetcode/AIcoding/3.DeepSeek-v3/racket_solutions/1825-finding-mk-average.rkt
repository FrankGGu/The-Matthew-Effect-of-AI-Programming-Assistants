(define-struct mkaverager (m k data sum first-m last-m))

(define (make-mkaverager m k)
  (make-mkaverager m k '() 0 '() '()))

(define (mkaverager-add-element avg num)
  (let* ([m (mkaverager-m avg)]
         [k (mkaverager-k avg)]
         [data (mkaverager-data avg)]
         [sum (mkaverager-sum avg)]
         [first-m (mkaverager-first-m avg)]
         [last-m (mkaverager-last-m avg)]
         [new-data (cons num data)]
         [new-len (add1 (length data))])
    (if (< new-len m)
        (struct-copy mkaverager avg
                     [data new-data]
                     [sum (+ sum num)])
        (if (= new-len m)
            (let* ([sorted (sort (cons num data) <)]
                   [new-first-m (take sorted m)]
                   [new-last-m (drop sorted (- m k))]
                   [new-sum (apply + (drop (take sorted (- m k)) k))])
              (struct-copy mkaverager avg
                           [data new-data]
                           [sum new-sum]
                           [first-m new-first-m]
                           [last-m new-last-m]))
            (let* ([old-num (list-ref data (sub1 m))]
                    [new-sorted (sort (cdr data) <)]
                    [new-sorted (insert-sorted new-sorted num)]
                    [new-sorted (remove-first old-num new-sorted)]
                    [new-first-m (take new-sorted m)]
                    [new-last-m (drop new-sorted (- m k))]
                    [new-sum (apply + (drop (take new-sorted (- m k)) k))])
              (struct-copy mkaverager avg
                           [data new-data]
                           [sum new-sum]
                           [first-m new-first-m]
                           [last-m new-last-m]))))))

(define (insert-sorted lst num)
  (cond [(null? lst) (list num)]
        [(<= num (car lst)) (cons num lst)]
        [else (cons (car lst) (insert-sorted (cdr lst) num))]))

(define (remove-first num lst)
  (cond [(null? lst) '()]
        [(= num (car lst)) (cdr lst)]
        [else (cons (car lst) (remove-first num (cdr lst)))]))

(define (mkaverager-calculate-mk-average avg)
  (let ([m (mkaverager-m avg)]
        [k (mkaverager-k avg)]
        [len (length (mkaverager-data avg))])
    (if (< len m)
        -1
        (let ([sum (mkaverager-sum avg)])
          (quotient sum (- m (* 2 k)))))))

(define MKAverage
  (let ([avg (make-mkaverager 0 0)])
    (case-lambda
      [() (MKAverage)]
      [(m k) (set! avg (make-mkaverager m k))]
      [(num) (set! avg (mkaverager-add-element avg num))]
      [('calculate-mk-average) (mkaverager-calculate-mk-average avg)])))