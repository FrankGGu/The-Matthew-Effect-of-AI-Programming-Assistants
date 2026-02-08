(define (reverseList head)
  (define (helper curr prev)
    (if (null? curr)
        prev
        (helper (cdr curr) curr)))
  (helper head null))