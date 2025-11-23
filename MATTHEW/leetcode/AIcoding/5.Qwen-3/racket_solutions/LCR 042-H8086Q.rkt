(define-struct queue (data))

(define (make-circular-queue)
  (make-queue '()))

(define (enqueue q x)
  (set-queue-data! q (append (queue-data q) (list x))))

(define (dequeue q)
  (let ((d (queue-data q)))
    (if (null? d)
        #f
        (begin
          (set-queue-data! q (cdr d))
          (car d)))))

(define (get-requests q)
  (queue-data q))

(define (main)
  (let* ((q (make-circular-queue))
         (n (read))
         (res '()))
    (for ([i (in-range n)])
      (let ((t (read)))
        (enqueue q t)
        (let loop ((count 0) (d (queue-data q)))
          (if (null? d)
              (begin
                (set! res (cons count res))
                #f)
              (if (<= (- t (car d)) 1000)
                  (loop (+ count 1) (cdr d))
                  (begin
                    (set! res (cons count res))
                    #f))))))
    (for-each display (reverse res))))

(main)