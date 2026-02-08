(define (getIntersectionNode headA headB)
  (define (length lst)
    (if (null? lst) 0 (+ 1 (length (cdr lst)))))

  (define lenA (length headA))
  (define lenB (length headB))

  (define (advance lst n)
    (if (zero? n) lst (advance (cdr lst) (- n 1))))

  (if (> lenA lenB)
      (set! headA (advance headA (- lenA lenB)))
      (set! headB (advance headB (- lenB lenA)))

  (define (findIntersection a b)
    (if (or (null? a) (null? b)) #f
        (if (eq? a b) a (findIntersection (cdr a) (cdr b)))))

  (findIntersection headA headB))