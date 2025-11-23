(define (minimum-effort-path heights)
  (define n (length heights))
  (define m (length (car heights)))
  (define directions '((0 1) (1 0) (0 -1) (-1 0)))

  (define (valid? x y)
    (and (>= x 0) (< x n) (>= y 0) (< y m)))

  (define (dijkstra)
    (define dist (make-vector n (make-vector m +inf.0)))
    (define pq (make-queue))
    (vector-set! (vector-ref dist 0) 0 0)
    (enqueue pq (list 0 0 0)) ; (effort, x, y)

    (define (get-effort x1 y1 x2 y2)
      (max (abs (- (list-ref (list-ref heights x1) y1) (list-ref (list-ref heights x2) y2))) 0))

    (define (process)
      (if (empty? pq) #f
          (let* ((current (dequeue pq))
                 (effort (car current))
                 (x (cadr current))
                 (y (caddr current)))
            (if (and (= x (- n 1)) (= y (- m 1))) effort
                (for-each (lambda (dir)
                            (let ((nx (+ x (car dir)))
                                  (ny (+ y (cadr dir))))
                              (when (valid? nx ny)
                                (let ((new-effort (+ effort (get-effort x y nx ny))))
                                  (when (< new-effort (vector-ref (vector-ref dist nx) ny))
                                    (vector-set! (vector-ref dist nx) ny new-effort)
                                    (enqueue pq (list new-effort nx ny))))))
                          directions)
                (process)))))

    (process))

  (dijkstra))