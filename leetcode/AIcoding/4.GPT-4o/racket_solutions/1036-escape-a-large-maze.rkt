(define (can-escape maze entrance)
  (define (in-bounds? pos)
    (and (>= (car pos) 0)
         (< (car pos) (length maze))
         (>= (cadr pos) 0)
         (< (cadr pos) (length (vector-ref maze 0)))))

  (define (visited? pos visited)
    (hash-ref visited pos #f))

  (define (mark-visited pos visited)
    (hash-set! visited pos #t))

  (define (dfs pos visited)
    (if (or (not (in-bounds? pos))
            (visited? pos visited)
            (equal? (vector-ref (vector-ref maze (car pos)) (cadr pos)) 1))
        #f
        (begin
          (mark-visited pos visited)
          (if (or (equal? pos entrance)
                  (or (= (car pos) 0)
                      (= (car pos) (- (length maze) 1))
                      (= (cadr pos) 0)
                      (= (cadr pos) (- (length (vector-ref maze 0)) 1)))
              #t
              (or (dfs (cons (car pos) (+ (cadr pos) 1)) visited)
                  (dfs (cons (car pos) (- (cadr pos) 1)) visited)
                  (dfs (cons (+ (car pos) 1) (cadr pos)) visited)
                  (dfs (cons (- (car pos) 1) (cadr pos)) visited))))))

  (dfs entrance (make-hash)))

(define (escape-maze maze entrance)
  (can-escape maze entrance))