(define (lexicographically-smallest-string-after-adjacent-removals s)
  (let loop ((stack '()) (str (string->list s)))
    (cond
      [(empty? str) (list->string (reverse stack))]
      [else
       (let ((c (car str)) (rest (cdr str)))
         (if (and (not (empty? stack)) (char<=? c (car stack)))
             (loop (cdr stack) rest)
             (loop (cons c stack) rest)))])))