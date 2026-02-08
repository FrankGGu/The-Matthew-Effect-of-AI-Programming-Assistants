(define (minimum-jumps a b c forbidden x)
  (define forbidden-set (set forbidden))
  (define queue (list (list 0 0 #f))) ; (position, steps, went-back?)
  (define visited (make-hash))
  (hash-set! visited (list 0 #f) #t)
  (define lower-bound 0)
  (define upper-bound (+ x b))

  (define (valid-move? pos went-back?)
    (and (not (set-member? forbidden-set pos))
         (<= lower-bound pos (+ x b a)) ; Extend upper bound
         (not (hash-has-key? visited (list pos went-back?)))))

  (define (bfs)
    (cond
      [(empty? queue) -1]
      [else
       (let* ((curr-node (car queue))
              (pos (car curr-node))
              (steps (cadr curr-node))
              (went-back? (caddr curr-node)))
         (if (= pos x)
             steps
             (begin
               (define next-nodes (list))
               ; Forward Jump
               (let ((next-pos (+ pos a)))
                 (if (valid-move? next-pos #f)
                     (begin
                       (set! next-nodes (append next-nodes (list (list next-pos (+ steps 1) #f))))
                       (hash-set! visited (list next-pos #f) #t))))
               ; Backward Jump
               (if (not went-back?)
                   (let ((next-pos (- pos b)))
                     (if (valid-move? next-pos #t)
                         (begin
                           (set! next-nodes (append next-nodes (list (list next-pos (+ steps 1) #t))))
                           (hash-set! visited (list next-pos #t) #t)))))
               (bfs (append (cdr queue) next-nodes)))))]))

  (bfs))