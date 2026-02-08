#lang racket

(define dining-philosophers%
  (class object%
    (super-new)
    (init-field forks)

    (define (pick-left-fork philosopher)
      (semaphore-wait (list-ref forks philosopher))
      (display-actions philosopher "pick" "left"))

    (define (pick-right-fork philosopher)
      (semaphore-wait (list-ref forks (modulo (add1 philosopher) 5))
      (display-actions philosopher "pick" "right"))

    (define (put-left-fork philosopher)
      (semaphore-post (list-ref forks philosopher))
      (display-actions philosopher "put" "left"))

    (define (put-right-fork philosopher)
      (semaphore-post (list-ref forks (modulo (add1 philosopher) 5)))
      (display-actions philosopher "put" "right"))

    (define (display-actions philosopher action fork)
      (displayln (format "~a ~a ~a fork" philosopher action fork)))

    (define/public (wants-to-eat philosopher pick-left pick-right eat put-left put-right)
      (pick-left-fork philosopher)
      (pick-right-fork philosopher)
      (eat)
      (put-right-fork philosopher)
      (put-left-fork philosopher))))

(define (make-semaphore-list n)
  (for/list ([i n]) (make-semaphore 1)))

(define (philosopher-thread philosopher dining)
  (thread
   (λ ()
     (let loop ()
       (send dining wants-to-eat
             philosopher
             (λ () (void))
             (λ () (void))
             (λ () (sleep 0.01))
             (λ () (void))
             (λ () (void)))
       (loop)))))

(define (start)
  (define forks (make-semaphore-list 5))
  (define dining (new dining-philosophers% [forks forks]))
  (for ([i 5]) (philosopher-thread i dining))