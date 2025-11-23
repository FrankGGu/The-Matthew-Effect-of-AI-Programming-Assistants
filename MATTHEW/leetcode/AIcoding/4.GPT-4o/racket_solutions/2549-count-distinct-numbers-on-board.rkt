(define (distinctNumbers board)
  (define (in-bounds? x y)
    (and (>= x 0) (< x (vector-length board))
         (>= y 0) (< y (vector-length (vector-ref board 0)))))

  (define (dfs x y seen)
    (if (not (in-bounds? x y)) 
        seen
        (let* ((num (vector-ref (vector-ref board x) y))
               (new-seen (set-add seen num)))
          (foldl (lambda (dir acc)
                    (dfs (+ x (car dir)) (+ y (cadr dir)) acc))
                  new-seen directions))))

  (define directions '((1 0) (-1 0) (0 1) (0 -1)))
  (set-count (dfs 0 0 (set)) 0))

(define (set-add s x)
  (set-union s (set (list x))))

(define (set-count s count)
  (if (set-empty? s)
      count
      (set-count (set-rest s) (+ count 1))))