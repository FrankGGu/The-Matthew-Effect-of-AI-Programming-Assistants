#lang racket

(define (get-skyline buildings)
  (define (compare a b)
    (if (= (car a) (car b))
        (<= (cadr a) (cadr b))
        (< (car a) (car b))))

  (define (merge left right)
    (cond [(null? left) right]
          [(null? right) left]
          [else
           (let ([l (car left)] [r (car right)])
             (if (<= (car l) (car r))
                 (cons l (merge (cdr left) right))
                 (cons r (merge left (cdr right)))))]))

  (define (split lst)
    (if (null? lst)
        (values '() '())
        (let* ([mid (quotient (length lst) 2)]
               [left (take lst mid)]
               [right (drop lst mid)])
          (values left right))))

  (define (sort lst)
    (if (null? lst)
        '()
        (let-values ([(left right) (split lst)])
          (merge (sort left) (sort right)))))

  (define (process events)
    (define (helper events prev-height result)
      (cond [(null? events) (reverse result)]
            [else
             (let* ([current (car events)]
                    [x (car current)]
                    [h (cadr current)]
                    [is-start (eqv? (caddr current) 'start)])
               (if is-start
                   (helper (cdr events) h (cons (list x h) result))
                   (let ([new-result (if (and (not (null? result)) (= (caar result) x))
                                         (let ([last (car result)])
                                           (cons (list x (max (cadr last) prev-height)) (cdr result)))
                                         (cons (list x prev-height) result))])
                     (helper (cdr events) h new-result)))])))
    (helper events 0 '()))

  (define events
    (for/fold ([acc '()]) ([b (in-list buildings)])
      (let ([x1 (car b)] [x2 (cadr b)] [h (caddr b)])
        (append acc (list (list x1 h 'start) (list x2 h 'end')))))

  (define sorted-events (sort events compare))

  (define processed (process sorted-events))

  (define (remove-duplicates lst)
    (cond [(null? lst) '()]
          [(null? (cdr lst)) lst]
          [else
           (let ([a (car lst)] [b (cadr lst)])
             (if (and (= (car a) (car b)) (= (cadr a) (cadr b)))
                 (remove-duplicates (cdr lst))
                 (cons a (remove-duplicates (cdr lst))))]))

  (remove-duplicates processed))