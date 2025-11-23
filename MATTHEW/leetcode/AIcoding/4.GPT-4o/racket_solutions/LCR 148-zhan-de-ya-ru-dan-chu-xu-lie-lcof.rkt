(define (validate-stack-sequences pushed popped)
  (define stack '())
  (define (helper push-index pop-index)
    (cond
      ((= pop-index (length popped)) #t)
      ((and (not (null? stack)) (equal? (car stack) (list-ref popped pop-index)))
       (begin
         (set! stack (cdr stack))
         (helper push-index (+ pop-index 1))))
      ((< push-index (length pushed))
       (begin
         (set! stack (cons (list-ref pushed push-index) stack))
         (helper (+ push-index 1) pop-index)))
      (else #f)))
  (helper 0 0))

(define (validateStackSequences pushed popped)
  (validate-stack-sequences pushed popped))