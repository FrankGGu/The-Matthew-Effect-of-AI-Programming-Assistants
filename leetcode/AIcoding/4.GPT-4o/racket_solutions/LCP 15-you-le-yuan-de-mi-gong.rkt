(define (can-reach-maze maze start destination)
  (define (in-bound? pos)
    (and (>= (car pos) 0) (< (car pos) (length maze))
         (>= (cadr pos) 0) (< (cadr pos) (length (car maze)))))

  (define (dfs pos visited)
    (if (equal? pos destination)
        #t
        (if (or (not (in-bound? pos)) (member pos visited))
            #f
            (let ((new-visited (cons pos visited)))
              (or (dfs (list (+ (car pos) 1) (cadr pos)) new-visited)
                  (dfs (list (- (car pos) 1) (cadr pos)) new-visited)
                  (dfs (list (car pos) (+ (cadr pos) 1)) new-visited)
                  (dfs (list (car pos) (- (cadr pos) 1)) new-visited))))))

  (dfs start '()))

(define (main)
  (define maze '((0 0 0) (0 1 0) (0 0 0)))
  (define start '(0 0))
  (define destination '(0 2))
  (can-reach-maze maze start destination))

(main)