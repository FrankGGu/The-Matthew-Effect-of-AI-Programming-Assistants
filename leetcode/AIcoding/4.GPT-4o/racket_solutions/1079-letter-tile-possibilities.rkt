(define (numTilePossibilities tiles)
  (define (count-possibilities current used)
    (if (null? current)
        0
        (+ 1 (apply + (map (lambda (i) (count-possibilities (remove-at i current) (cons i used))) (iota (length current)))))))
  (count-possibilities (string->list tiles) '()))

(define (remove-at index lst)
  (append (take lst index) (drop lst (+ index 1))))

(define (iota n)
  (if (= n 0)
      '()
      (cons (- n 1) (iota (- n 1)))))