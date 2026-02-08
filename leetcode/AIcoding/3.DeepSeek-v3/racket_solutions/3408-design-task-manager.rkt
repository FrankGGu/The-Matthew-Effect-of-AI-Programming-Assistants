(define task-manager%
  (class object%
    (super-new)
    (init-field)
    (define tasks (make-hash))

    (define/public (add-task task-id priority)
      (hash-set! tasks task-id priority))

    (define/public (get-top-priority)
      (if (hash-empty? tasks)
          -1
          (apply max (hash-values tasks))))

    (define/public (remove-top-priority)
      (define max-priority (get-top-priority))
      (when (not (= max-priority -1))
        (define task-ids (for/list ([(id p) (in-hash tasks)] #:when (= p max-priority)) id)
        (define task-id (car task-ids))
        (hash-remove! tasks task-id)
        task-id))

    (define/public (cancel-task task-id)
      (if (hash-has-key? tasks task-id)
          (begin
            (hash-remove! tasks task-id)
            #t)
          #f)))