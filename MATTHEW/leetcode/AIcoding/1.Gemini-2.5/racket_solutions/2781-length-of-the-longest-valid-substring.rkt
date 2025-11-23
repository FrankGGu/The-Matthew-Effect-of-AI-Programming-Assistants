#lang racket

(define (longest-valid-parentheses s)
  (define n (string-length s))

  (define-values (final-max-len _ __)
    (for/fold ([max-len 0]
               [stack '()] ; stack stores indices of '('
               [base-index -1]) ; index before the start of current potential valid substring
              ([i (in-range n)])
      (define current-char (string-ref s i))

      (cond
        [(char=? current-char #\( )
         (values max-len (cons i stack) base-index)]

        [(char=? current-char #\) )
         (if (empty? stack)
             (values max-len '() i)
             (let* ([_ (car stack)]
                    [new-stack (cdr stack)])
               (if (empty? new-stack)
                   (values (max max-len (- i base-index)) new-stack base-index)
                   (values (max max-len (- i (car new-stack))) new-stack base-index))))]
        [else
         (values max-len stack base-index)])))
  final-max-len)