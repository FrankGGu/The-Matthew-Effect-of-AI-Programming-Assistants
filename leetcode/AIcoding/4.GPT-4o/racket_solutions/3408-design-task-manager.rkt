(define-task-manager
  (let ([task-map (make-hash)])
    (define (add-task task-id)
      (hash-set! task-map task-id #f))

    (define (remove-task task-id)
      (hash-remove! task-map task-id))

    (define (complete-task task-id)
      (hash-set! task-map task-id #t))

    (define (get-incomplete-tasks)
      (hash-filter (lambda (k v) (not v)) task-map))

    (define (get-complete-tasks)
      (hash-filter (lambda (k v) v) task-map))

    (lambda (cmd . args)
      (cond
        [(equal? cmd 'add) (add-task (car args))]
        [(equal? cmd 'remove) (remove-task (car args))]
        [(equal? cmd 'complete) (complete-task (car args))]
        [(equal? cmd 'get-incomplete) (get-incomplete-tasks)]
        [(equal? cmd 'get-complete) (get-complete-tasks)]
        [else (error "Unknown command")]))))