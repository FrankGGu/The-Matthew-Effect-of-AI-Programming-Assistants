(require racket/list)

(define (remove-k-digits num k)
  (let loop ((digits (string->list num))
             (stack '())
             (rem-k k))
    (if (null? digits)
        (let* ((final-stack (if (> rem-k 0)
                                (drop stack rem-k)
                                stack))
               (reversed-result (reverse final-stack))
               (cleaned-result (drop-while (lambda (c) (char=? c #\0)) reversed-result)))
          (if (null? cleaned-result)
              "0"
              (list->string cleaned-result)))
        (let* ((current-digit (car digits))
               (rest-digits (cdr digits)))
          (cond
            ((and (not (null? stack))
                  (char<? current-digit (car stack))
                  (> rem-k 0))
             (loop digits (cdr stack) (- rem-k 1)))
            (else
             (loop rest-digits (cons current-digit stack) rem-k)))))))