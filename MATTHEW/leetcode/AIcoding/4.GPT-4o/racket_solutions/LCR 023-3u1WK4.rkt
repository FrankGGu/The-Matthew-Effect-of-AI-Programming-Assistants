(define (getIntersectionNode headA headB)
  (define (length-list head)
    (if (null? head)
        0
        (+ 1 (length-list (cdr head)))))
  (define lenA (length-list headA))
  (define lenB (length-list headB))
  (define (advance-list head n)
    (if (zero? n)
        head
        (advance-list (cdr head) (- n 1))))
  (define diff (abs (- lenA lenB)))
  (define (find-intersection a b)
    (if (eq? a b)
        a
        (find-intersection (cdr a) (cdr b))))
  (if (> lenA lenB)
      (find-intersection (advance-list headA diff) headB)
      (find-intersection headA (advance-list headB diff))))