(define (assignTasks servers tasks)
  (define n (length servers))
  (define m (length tasks))
  (define server-queue (make-queue))
  (define task-queue (make-queue))
  (define available-servers (for/list ([i (in-range n)]) (list i (list-ref servers i) 0)))

  (for-each (lambda (i) (enqueue server-queue (list (list-ref available-servers i) i)))
            (in-range n))

  (for-each (lambda (task)
              (let loop ()
                (let* ([server (dequeue server-queue)]
                       [time (second server)]
                       [index (second (first server))])
                  (if (or (null? server) (>= time (car task)))
                      (begin
                        (enqueue task-queue (list index (car task)))
                        (enqueue server-queue (list (list-ref available-servers index) index)))
                      (begin
                        (enqueue task-queue (list index time))
                        (enqueue server-queue (list (list-ref available-servers index) index))
                        (loop))))))
            tasks)

  (define result '())

  (for-each (lambda (task)
              (let* ([index (car task)]
                     [time (cadr task)]
                     [server (list-ref available-servers index)])
                (set-car! (cdr server) (max (cdr server) (+ time (car server))))))
            (dequeue-all task-queue))

  (map car (sort task-queue (lambda (a b) (< (cadr a) (cadr b))))))
)