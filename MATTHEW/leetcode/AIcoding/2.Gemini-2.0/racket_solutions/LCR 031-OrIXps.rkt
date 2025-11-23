(define (lru-cache capacity)
  (let* ((cache (make-hash))
         (capacity capacity)
         (head (box #f))
         (tail (box #f))
         (size (box 0))

         (make-node (lambda (key value)
                      (hash-set! cache key (cons value (cons (box #f) (cons (box #f) '()))))
                      (hash-ref cache key)))

         (add-node (lambda (node)
                     (let ((head-node (unbox head)))
                       (if head-node
                           (begin
                             (set-box! (cdr (cdr node))) head-node)
                             (set-box! (cdr (cdr head-node))) node)
                           (set-box! tail node))
                       (set-box! head node))))

         (remove-node (lambda (node)
                        (let ((prev (unbox (cdr node)))
                              (next (unbox (cdr (cdr node)))))
                          (if prev
                              (set-box! (cdr (cdr prev)) next)
                              (set-box! head next))
                          (if next
                              (set-box! (cdr next) prev)
                              (set-box! tail prev))
                          (set-box! (cdr node) #f)
                          (set-box! (cdr (cdr node)) #f))))

         (move-to-head (lambda (node)
                         (remove-node node)
                         (add-node node)))

         (get (lambda (key)
                (if (hash-has-key? cache key)
                    (let ((node (hash-ref cache key)))
                      (move-to-head node)
                      (car node))
                    -1)))

         (put (lambda (key value)
                (if (hash-has-key? cache key)
                    (let ((node (hash-ref cache key)))
                      (set-car! node value)
                      (move-to-head node))
                    (begin
                      (let ((node (make-node key value)))
                        (add-node node)
                        (set-box! size (+ (unbox size) 1))
                        (if (> (unbox size) capacity)
                            (let ((tail-node (unbox tail)))
                              (remove-node tail-node)
                              (hash-remove! cache (hash-key cache tail-node))
                              (set-box! size (- (unbox size) 1)))))))))
         (hash-key (lambda (cache node)
                     (hash-fold (lambda (k v acc)
                                  (if (equal? v node)
                                      k
                                      acc)) #f cache)))
         )
    (lambda (method . args)
      (case method
        ((get) (apply get args))
        ((put) (apply put args))
        (else (error "Invalid method"))))))