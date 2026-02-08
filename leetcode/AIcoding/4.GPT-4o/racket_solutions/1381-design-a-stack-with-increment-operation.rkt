(define Stack
  (lambda ()
    (define stack '())
    (define increment-list '())
    (define (push x)
      (set! stack (cons x stack))
      (set! increment-list (cons 0 increment-list)))
    (define (pop)
      (if (null? stack)
          -1
          (let* ((increment (car increment-list))
                 (value (car stack)))
            (set! stack (cdr stack))
            (set! increment-list (cdr increment-list))
            (when (not (null? (cdr stack)))
              (set! (car increment-list) (+ increment (car increment-list))))
            (+ value increment))))
    (define (increment k val)
      (if (null? stack)
          '()
          (set! (car increment-list) (+ val (car increment-list)))))
    (define (get-stack) stack)
    (define (get-increment-list) increment-list)
    (define (get-push) push)
    (define (get-pop) pop)
    (define (get-increment) increment)
    (list get-push get-pop get-increment)))

(define myStack (Stack))
(define push (car myStack))
(define pop (cadr myStack))
(define increment (caddr myStack))

(push 1)
(push 2)
(increment 2 5)
(display (pop)) ; returns 7
(display (pop)) ; returns 1
(display (pop)) ; returns -1