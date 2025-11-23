#lang racket

(define (escape-large-maze grid)
  (define rows (length grid))
  (define cols (if (> rows 0) (length (car grid)) 0))
  (define visited (make-hash))
  (define (in-bounds r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))
  (define (is-free r c)
    (and (in-bounds r c) (= (list-ref (list-ref grid r) c) 0)))
  (define (bfs start-r start-c)
    (define queue (list (cons start-r start-c)))
    (define (loop q count)
      (cond [(null? q) #f]
            [else
             (define r (car (car q)))
             (define c (cdr (car q)))
             (when (and (in-bounds r c) (is-free r c) (not (hash-has-key? visited (cons r c))))
               (hash-set! visited (cons r c) #t)
               (when (or (= r 0) (= r (sub1 rows)) (= c 0) (= c (sub1 cols))) (set! count 10000))
               (loop (append (cdr q)
                             (filter (lambda (p) (and (in-bounds (car p) (cdr p)) (is-free (car p) (cdr p)) (not (hash-has-key? visited p)))) 
                                     (list (cons (add1 r) c) (cons (sub1 r) c) (cons r (add1 c)) (cons r (sub1 c)))))
                     (add1 count))]))
    (loop queue 0))
  (define (solve)
    (if (or (not (in-bounds 0 0)) (not (is-free 0 0)) (not (in-bounds (sub1 rows) (sub1 cols))) (not (is-free (sub1 rows) (sub1 cols))))
        #f
        (let ([start-result (bfs 0 0)])
          (if start-result #t
              (let ([end-result (bfs (sub1 rows) (sub1 cols))])
                end-result)))))
  (solve))