(define/contract (pair-sum head)
  (-> (or/c list? null?) exact-integer?)
  (let loop ([slow head] [fast head] [stack null])
    (if (null? fast)
        (let loop ([slow slow] [stack stack] [max-sum 0])
          (if (null? slow)
              max-sum
              (loop (cdr slow) (cdr stack) (max max-sum (+ (car slow) (car stack))))))
        (if (null? (cdr fast))
            (let loop ([slow (cdr slow)] [stack stack] [max-sum 0])
              (if (null? slow)
                  max-sum
                  (loop (cdr slow) (cdr stack) (max max-sum (+ (car slow) (car stack)))))
            (loop (cdr slow) (cddr fast) (cons (car slow) stack))))))