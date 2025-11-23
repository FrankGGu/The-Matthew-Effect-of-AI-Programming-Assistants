(define (hit-bricks bricks hits)
  (define m (length bricks))
  (define n (length (car bricks)))
  (define grid (make-vector m (make-vector n 0)))
  (for* ((i m) (j n))
    (vector-set! (vector-ref grid i) j (list-ref (list-ref bricks i) j)))

  (define (get-neighbors i j)
    (filter (lambda (pos) (and (>= (car pos) 0) (< (car pos) m) (>= (cdr pos) 0) (< (cdr pos) n)))
            (list (cons (- i 1) j) (cons (+ i 1) j) (cons i (- j 1)) (cons i (+ j 1)))))

  (define (dfs i j visited)
    (if (or (< i 0) (>= i m) (< j 0) (>= j n) (memq (cons i j) visited) (= (vector-ref (vector-ref grid i) j) 0))
        0
        (begin
          (set! visited (cons (cons i j) visited))
          (+ 1 (apply + (map (lambda (neighbor) (dfs (car neighbor) (cdr neighbor) visited)) (get-neighbors i j)))))))

  (define (is-connected i j)
    (if (= i 0)
        #t
        (let loop ((neighbors (get-neighbors i j)))
          (cond
            ((null? neighbors) #f)
            ((and (>= (car (car neighbors)) 0) (< (car (car neighbors)) m) (>= (cdr (car neighbors)) 0) (< (cdr (car neighbors)) n) (= (vector-ref (vector-ref (car (car neighbors)) (cdr (car neighbors))) 0) 2)) #t)
            (else (loop (cdr neighbors)))))))

  (define (mark-connected)
    (for ((j n))
      (if (= (vector-ref (vector-ref grid 0) j) 1)
          (let loop ((stack (list (cons 0 j))) (visited '()))
            (if (null? stack)
                #void
                (let ((curr (car stack)))
                  (if (memq curr visited)
                      (loop (cdr stack) visited)
                      (begin
                        (vector-set! (vector-ref grid (car curr)) (cdr curr) 2)
                        (loop (append (cdr stack) (filter (lambda (neighbor) (and (>= (car neighbor) 0) (< (car neighbor) m) (>= (cdr neighbor) 0) (< (cdr neighbor) n) (= (vector-ref (vector-ref grid (car neighbor)) (cdr neighbor)) 1))) (get-neighbors (car curr) (cdr curr)))) (cons curr visited))))))))))

  (define result '())

  (for ((hit (reverse hits)))
    (let* ((i (car hit)) (j (cdr hit)) (original-value (vector-ref (vector-ref grid i) j)))
      (vector-set! (vector-ref grid i) j 1)
      (if (is-connected i j)
          (begin
            (mark-connected)
            (let ((count (- (dfs i j '()) 1)))
              (set! result (cons count result))))
          (begin
            (vector-set! (vector-ref grid i) j 0)
            (set! result (cons 0 result))))))

  (reverse result))