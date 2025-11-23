#lang racket
(require racket/set)

(define (is-valid? x y rows cols)
  (and (>= x 0) (< x rows) (>= y 0) (< y cols)))

(define (disconnect-path matrix)
  (define rows (length matrix))
  (define cols (length (first matrix)))
  (define directions '((0 1) (1 0) (0 -1) (-1 0)))
  (define start (cons 0 0))
  (define end (cons (- rows 1) (- cols 1)))
  (define visited (make-hash))

  (define (dfs pos flipped)
    (if (equal? pos end)
      #t
      (for/or ([dir directions])
        (define new-x (+ (car pos) (car dir)))
        (define new-y (+ (cdr pos) (cdr dir)))
        (when (is-valid? new-x new-y rows cols)
          (define new-flipped (if (= (list-ref (list-ref matrix new-x) new-y) 1) 
                                   (+ flipped 1) 
                                   flipped))
          (when (<= new-flipped 1)
            (unless (hash-ref visited (cons new-x new-y) #f)
              (hash-set! visited (cons new-x new-y) #t)
              (dfs (cons new-x new-y) new-flipped)))))))

  (dfs start 0))

(define (solve matrix)
  (if (or (not (equal? (list-ref (list-ref matrix 0) 0) 0))
          (not (equal? (list-ref (list-ref matrix (- (length matrix) 1)) 
                                  (- (length (first matrix)) 1)) 0)))
      #f
      (disconnect-path matrix)))