(require racket/base)
(require data/queue)
(require racket/hash)

(define (bfs forest start-r start-c end-r end-c rows cols)
  (call-with-current-continuation
   (lambda (return)
     (when (and (= start-r end-r) (= start-c end-c))
       (return 0))

     (define q (make-queue))
     (define visited (make-hash equal?)) ; Use equal? for list keys

     (queue-add! q (list start-r start-c 0)) ; (r c dist)
     (hash-set! visited (list start-r start-c) #t)

     (define dr (list -1 1 0 0))
     (define dc (list 0 0 -1 1))

     (let loop ()
       (if (queue-empty? q)
           -1 ; Unreachable
           (let* ((current (queue-pop! q))
                  (r (list-ref current 0))
                  (c (list-ref current 1))
                  (dist (list-ref current 2)))

             (for ([i (range 4)])
               (let* ((nr (+ r (list-ref dr i)))
                      (nc (+ c (list-ref dc i))))
                 (when (and (>= nr 0) (< nr rows)
                            (>= nc 0) (< nc cols)
                            (not (hash-has-key? visited (list nr nc)))
                            (not (= (list-ref (list-ref forest nr) nc) 0))) ; Cannot walk through 0
                   (if (and (= nr end-r) (= nc end-c))
                       (return (+ dist 1)) ; Found path
                       (begin
                         (hash-set! visited (list nr nc) #t)
                         (queue-add! q (list nr nc (+ dist 1))))))))
             (loop)))))))

(define (cut-off-tree forest)
  (call-with-current-continuation
   (lambda (return)
     (define rows (length forest))
     (define cols (if (> rows 0) (length (list-ref forest 0)) 0))

     (when (or (= rows 0) (= cols 0))
       (return 0))

     (define trees
       (for*/list ([r (range rows)]
                   [c (range cols)]
                   #:when (> (list-ref (list-ref forest r) c) 1))
         (list (list-ref (list-ref forest r) c) r c)))

     (set! trees (sort trees (lambda (t1 t2) (< (list-ref t1 0) (list-ref t2 0)))))

     (define total-dist 0)
     (define current-r 0)
     (define current-c 0)

     (for ([tree trees])
       (let* ((target-r (list-ref tree 1))
              (target-c (list-ref tree 2)))
         (let ((dist (bfs forest current-r current-c target-r target-c rows cols)))
           (if (= dist -1)
               (return -1)
               (begin
                 (set! total-dist (+ total-dist dist))
                 (set! current-r target-r)
                 (set! current-c target-c))))))

     total-dist)))