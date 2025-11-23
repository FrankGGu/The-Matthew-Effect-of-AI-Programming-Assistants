(define (update-matrix matrix)
  (let* ([m (vector-length matrix)]
         [n (vector-length (vector-ref matrix 0))]
         [dist (make-vector m (lambda (i) (make-vector n (lambda (j) (if (= (vector-ref (vector-ref matrix i) j) 0) 0 (+ m n))))))]
         [q (queue)]
         (for ([i (in-range m)])
           (for ([j (in-range n)])
             (if (= (vector-ref (vector-ref matrix i) j) 0)
                 (enqueue! q (list i j)))))
         (let loop ()
           (if (queue-empty? q)
               dist
               (let* ([curr (dequeue! q)]
                      [r (car curr)]
                      [c (cadr curr)]
                      [directions '((0 1) (0 -1) (1 0) (-1 0))])
                 (for ([dir (in-list directions)])
                   (let* ([nr (+ r (car dir))]
                          [nc (+ c (cadr dir))])
                     (if (and (>= nr 0) (< nr m) (>= nc 0) (< nc n)
                              (> (vector-ref (vector-ref dist nr) nc) (+ (vector-ref (vector-ref dist r) c) 1)))
                         (begin
                           (vector-set! (vector-ref dist nr) nc (+ (vector-ref (vector-ref dist r) c) 1))
                           (enqueue! q (list nr nc))))))
                 (loop))))))