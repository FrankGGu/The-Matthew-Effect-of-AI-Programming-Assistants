(require racket/string)

(define (reverse-parentheses s)
  (let loop ((idx 0)
             (current-segment "")
             (stack '()))
    (if (= idx (string-length s))
        current-segment
        (let ((char (string-ref s idx)))
          (cond
            ((char=? char #\()
             (loop (+ idx 1) "" (cons current-segment stack)))
            ((char=? char #\))
             (let ((prev-segment (car stack))
                   (rest-stack (cdr stack)))
               (loop (+ idx 1)
                     (string-append prev-segment (string-reverse current-segment))
                     rest-stack)))
            (else ; a letter
             (loop (+ idx 1)
                   (string-append current-segment (string char))
                   stack)))))))