(define (spam-report)
  (let* ((spam-threshold 3)
         (spam-users
          (hash-keys
           (hash-filter
            (hash-map
             (group-by (lambda (x) (hash-ref x 'sender_id))
                       (select 'messages (list 'sender_id 'content)))
             (lambda (k v) (length v)))
            (lambda (k v) (> v spam-threshold)))))
         (spam-messages
          (select 'messages (list 'message_id)
                  (lambda (row) (member? (hash-ref row 'sender_id) spam-users)))))
    spam-messages))