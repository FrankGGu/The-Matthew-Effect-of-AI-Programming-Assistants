(define seat-reservation-manager%
  (class object%
    (super-new)
    (init-field n)
    (field [available-seats (make-heap (λ (a b) (< a b)))])

    (begin
      (for ([i (in-range 1 (add1 n))])
        (heap-add! available-seats i)))

    (define/public (reserve)
      (heap-min available-seats))

    (define/public (unreserve seat-number)
      (heap-add! available-seats seat-number))))

(define heap%
  (class object%
    (super-new)
    (init-field [cmp <])
    (field [heap '()])

    (define/public (heap-add! x)
      (set! heap (insert heap x))
      (void))

    (define/public (heap-min)
      (if (null? heap)
          (error "Heap is empty")
          (let ([min-val (car heap)])
            (set! heap (delete-min heap))
            min-val)))

    (define (insert h x)
      (cond
        [(null? h) (list x)]
        [else
         (let ([root (car h)]
               [rest (cdr h)])
           (if (cmp x root)
               (cons x (cons root rest))
               (cons root (insert rest x))))]))

    (define (delete-min h)
      (if (null? (cdr h))
          '()
          (let ([root (car h)]
                [next (cadr h)]
                [rest (cddr h)])
            (if (cmp root next)
                (cons next (delete-min (cons root rest)))
                (cons root (delete-min (cons next rest))))))))

(define (make-heap cmp)
  (new heap% [cmp cmp]))