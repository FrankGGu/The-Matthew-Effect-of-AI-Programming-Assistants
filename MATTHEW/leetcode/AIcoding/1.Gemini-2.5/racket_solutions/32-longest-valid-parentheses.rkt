(define (longest-valid-parentheses s)
  (let* ([n (string-length s)]
         [stack (list -1)] ; Initialize stack with -1
         [max-len 0])
    (for ([i (in-range n)])
      (let ([char (string-ref s i)])
        (cond
          [(char=? char #\()
           (set! stack (cons i stack))]
          [(char=? char #\))
           (set! stack (cdr stack)) ; Pop
           (if (null? stack)
               (set! stack (cons i stack)) ; Stack empty, push current index
               (set! max-len (max max-len (- i (car stack)))))])))
    max-len))