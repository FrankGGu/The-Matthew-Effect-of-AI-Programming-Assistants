#lang racket

(define (checkWays pairs)
  (define adj (make-hash))
  (define nodes (mutable-set))

  (for ([pair pairs])
    (let ([u (car pair)]
          [v (cadr pair)])
      (set-add! nodes u)
      (set-add! nodes v)
      (hash-update! adj u (lambda (lst) (cons v lst)) '())
      (hash-update! adj v (lambda (lst) (cons u lst)) '())))

  (define node-list (sort (set->list nodes) >))
  (define parent (make-hash))
  (define result 1)

  (for ([u node-list])
    (define neighbors (filter (lambda (v) (and (hash-has-key? adj v) (member u (hash-ref adj v)))) node-list))
    (define candidates (filter (lambda (v) (and (hash-has-key? parent v) (= (length (hash-ref adj v)) (length (hash-ref adj u))))) neighbors)

    (if (empty? candidates)
        (if (not (= (length (hash-ref adj u)) (- (length node-list) 1)))
            (set! result 0)
            (when (= result 1)
              (set! result 2)))
        (let ([p (car candidates)])
          (for ([v (hash-ref adj u)])
            (when (and (not (= v p)) (not (member v (hash-ref adj p))))
              (set! result 0)))
          (hash-set! parent u p))))

  result)