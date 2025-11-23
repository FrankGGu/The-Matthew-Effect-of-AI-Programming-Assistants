(define (remove-duplicates s k)
  (let loop ([str (string->list s)] [stack '()])
    (cond
      [(null? str)
       (list->string (map car stack))]
      [(empty? stack)
       (loop (cdr str) (list (cons (car str) 1)))]
      [(char=? (caar stack) (car str))
       (let ([count (cdar stack)])
         (if (= (+ count 1) k)
             (loop (cdr str) (cdr stack))
             (loop (cdr str) (cons (cons (car str) (+ count 1)) (cdr stack)))))]
      [else
       (loop (cdr str) (cons (cons (car str) 1) stack))])))