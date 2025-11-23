#lang racket

(struct task (id description priority status) #:mutable)

(define (make-task-manager)
  (define next-id 1)
  (define tasks (make-hash))

  (define (add-task description priority)
    (let* ((current-id next-id)
           (new-task (task current-id description priority 'pending)))
      (hash-set! tasks current-id new-task)
      (set! next-id (+ next-id 1))
      current-id))

  (define (get-task id)
    (let ((t (hash-ref tasks id #f)))
      (if t
          (list (task-description t) (task-priority t) (task-status t))
          #f)))

  (define (complete-task id)
    (let ((t (hash-ref tasks id #f)))
      (if (and t (eq? (task-status t) 'pending))
          (begin
            (set-task-status! t 'completed)
            #true)
          #false)))

  (define (update-priority id new-priority)
    (let ((t (hash-ref tasks id #f)))
      (if t
          (begin
            (set-task-priority! t new-priority)
            #true)
          #false)))

  (lambda (command . args)
    (case command
      ['add-task (apply add-task args)]
      ['get-task (apply get-task args)]
      ['complete-task (apply complete-task args)]
      ['update-priority (apply update-priority args)]
      [else (error "Unknown command" command)])))