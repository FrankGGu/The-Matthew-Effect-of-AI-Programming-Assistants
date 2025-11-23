(define (get-intersection-node headA headB)
  (define (length lst)
    (cond
      [(null? lst) 0]
      [else (+ 1 (length (cdr lst)))]))

  (define (advance lst n)
    (if (= n 0)
        lst
        (advance (cdr lst) (- n 1))))

  (let* ([lenA (length headA)]
         [lenB (length headB)]
         [diff (abs (- lenA lenB))]
         [longer (if (> lenA lenB) headA headB)]
         [shorter (if (> lenA lenB) headB headA)]
         [advanced-longer (advance longer diff)])
    (let loop ([a advanced-longer] [b shorter])
      (cond
        [(null? a) #f]
        [(null? b) #f]
        [(eq? a b) a]
        [else (loop (cdr a) (cdr b))])))
)