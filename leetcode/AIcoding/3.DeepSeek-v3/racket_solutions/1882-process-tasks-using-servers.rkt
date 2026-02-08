(define/contract (assign-tasks servers tasks)
  (-> (listof exact-integer?) (listof exact-integer?) (listof exact-integer?))
  (define pq-free (make-priority-queue (lambda (a b) (if (= (car a) (car b)) (< (cdr a) (cdr b)) (< (car a) (car b)))))
  (define pq-busy (make-priority-queue (lambda (a b) (< (car a) (car b)))))
  (for ([i (in-range (length servers))]
        [s (in-list servers)])
    (priority-queue-push! pq-free (cons s i)))

  (define res '())
  (define time 0)
  (define n (length tasks))

  (let loop ([i 0])
    (when (< i n)
      (while (and (not (priority-queue-empty? pq-busy))
                  (<= (car (priority-queue-min pq-busy)) time))
        (define freed (priority-queue-pop! pq-busy))
        (priority-queue-push! pq-free (cdr freed)))

      (if (not (priority-queue-empty? pq-free))
          (let ([server (priority-queue-pop! pq-free)])
            (set! res (cons (cdr server) res))
            (priority-queue-push! pq-busy (cons (+ time (list-ref tasks i)) server))
            (loop (add1 i)))
          (begin
            (set! time (car (priority-queue-min pq-busy)))
            (loop i)))))
  (reverse res))