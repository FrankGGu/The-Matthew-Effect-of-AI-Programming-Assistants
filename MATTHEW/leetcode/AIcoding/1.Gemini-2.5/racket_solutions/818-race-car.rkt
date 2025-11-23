#lang racket

(require racket/queue)
(require racket/hash)

(define (racecar target)
  (call-with-current-continuation
   (lambda (return)
     (let ((q (make-queue))
           (visited (make-hash)))

       (queue-add! q (list 0 0 1))
       (hash-set! visited (cons 0 1) #t)

       (let search-loop ()
         (when (not (queue-empty? q))
           (let* ((current-state (queue-remove! q))
                  (steps (car current-state))
                  (pos (cadr current-state))
                  (speed (caddr current-state)))

             (when (= pos target)
               (return steps))

             (let* ((next-pos-A (+ pos speed))
                    (next-speed-A (* speed 2))
                    (next-state-A (cons next-pos-A next-speed-A)))
               (when (and (not (hash-has-key? visited next-state-A))
                          (<= 0 next-pos-A (* 2 target))
                          (<= (abs next-speed-A) (* 2 target)))
                 (hash-set! visited next-state-A #t)
                 (queue-add! q (list (add1 steps) next-pos-A next-speed-A))))

             (let* ((next-pos-R pos)
                    (next-speed-R (if (> speed 0) -1 1))
                    (next-state-R (cons next-pos-R next-speed-R)))
               (when (not (hash-has-key? visited next-state-R))
                 (hash-set! visited next-state-R #t)
                 (queue-add! q (list (add1 steps) next-pos-R next-speed-R))))

             (search-loop))))))))