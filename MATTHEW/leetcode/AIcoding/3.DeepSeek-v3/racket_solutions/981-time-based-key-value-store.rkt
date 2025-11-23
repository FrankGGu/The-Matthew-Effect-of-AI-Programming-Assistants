(define time-map%
  (class object%
    (super-new)
    (init-field)
    (define h (make-hash))

    (define/public (set key value timestamp)
      (hash-update! h key
                    (lambda (lst) (cons (cons timestamp value) lst)
                    (lambda () '())))

    (define/public (get key timestamp)
      (define lst (hash-ref h key '()))
      (define (binary-search lst target)
        (let loop ([left 0]
                   [right (sub1 (length lst))])
          (if (> left right)
              (if (>= right 0) (car (list-ref lst right)) "")
              (let* ([mid (quotient (+ left right) 2)]
                     [mid-pair (list-ref lst mid)]
                     [mid-time (car mid-pair)])
                (cond
                  [(= mid-time target) (cdr mid-pair)]
                  [(< mid-time target) (loop (add1 mid) right)]
                  [else (loop left (sub1 mid))])))))
      (binary-search (sort lst (lambda (a b) (< (car a) (car b)))) timestamp))