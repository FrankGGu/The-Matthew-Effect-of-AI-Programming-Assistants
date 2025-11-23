(define (num-similar-groups strs)
  (define (are-similar s1 s2)
    (let loop ((s1 s1) (s2 s2) (diff 0))
      (cond
        [(or (null? s1) (null? s2)) (= diff 2)]
        [(equal? (car s1) (car s2)) (loop (cdr s1) (cdr s2) diff)]
        [(= diff 2) #f]
        [else (loop (cdr s1) (cdr s2) (+ diff 1))])))

  (define (dfs index visited)
    (set! visited (set-add visited index))
    (for-each (lambda (i)
                (when (and (not (set-member? visited i)) (are-similar (list-ref strs index) (list-ref strs i)))
                  (dfs i visited)))
              (range (length strs)))
    visited)

  (define visited (make-set))
  (define count 0)

  (for-each (lambda (i)
              (when (not (set-member? visited i))
                (dfs i visited)
                (set! count (+ count 1))))
            (range (length strs)))
  count)

(define (numSimilarGroups strs)
  (num-similar-groups strs))