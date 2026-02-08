#lang racket

(define (containsCycle grid)
  (define rows (length grid))
  (when (zero? rows) (return #f))
  (define cols (string-length (car grid)))
  (define visited (make-hash))

  (define (dfs i j prev-i prev-j char)
    (hash-set! visited (cons i j) #t)
    (for ([dir '((0 1) (1 0) (0 -1) (-1 0))])
      (define ni (+ i (car dir)))
      (define nj (+ j (cadr dir)))
      (cond
        [(or (< ni 0) (>= ni rows) (< nj 0) (>= nj cols)) #f]
        [(not (equal? (string-ref (list-ref grid ni) nj) char)) #f]
        [(and (= ni prev-i) (= nj prev-j)) #f]
        [(hash-has-key? visited (cons ni nj)) #t]
        [else (dfs ni nj i j char)])))

  (for/or ([i (in-range rows)])
    (for/or ([j (in-range cols)])
      (and (not (hash-has-key? visited (cons i j)))
           (dfs i j -1 -1 (string-ref (list-ref grid i) j)))))