(define (remove-leaves root target)
  (cond
    [(null? root) #f]
    [(and (null? (left root)) (null? (right root))
          (= (val root) target)) #f]
    [else (make-node (val root)
                     (remove-leaves (left root) target)
                     (remove-leaves (right root) target))]))

(define (delete-leaves root target)
  (remove-leaves root target))