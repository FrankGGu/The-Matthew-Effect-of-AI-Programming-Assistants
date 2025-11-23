(define-struct node (value prev next))

(define (make-browser-history)
  (let ((current (make-node "" #f #f)))
    (lambda (msg . args)
      (cond
        [(eq? msg 'visit)
         (let* ((url (car args))
                (new-node (make-node url current #f)))
           (set-node-next! current new-node)
           (set! current new-node)
           #t)]
        [(eq? msg 'back)
         (let ((steps (car args)))
           (do ((i 0 (+ i 1)))
               ((or (= i steps) (not (node-prev current))))
             (set! current (node-prev current)))
           (node-value current))]
        [(eq? msg 'forward)
         (let ((steps (car args)))
           (do ((i 0 (+ i 1)))
               ((or (= i steps) (not (node-next current))))
             (set! current (node-next current)))
           (node-value current))]))))