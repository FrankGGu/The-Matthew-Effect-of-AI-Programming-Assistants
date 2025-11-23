#lang racket

(define (score-of-parentheses s)
  (let loop ((idx 0)
             (current-score 0)
             (score-stack '()))
    (if (= idx (string-length s))
        current-score
        (let ((char (string-ref s idx)))
          (cond
            ((char=? char #\()
             (loop (+ idx 1) 0 (cons current-score score-stack)))
            ((char=? char #\))
             (let* ((prev-score (car score-stack))
                    (new-stack (cdr score-stack))
                    (score-to-add (if (= current-score 0) 1 (* 2 current-score))))
               (loop (+ idx 1) (+ prev-score score-to-add) new-stack)))
            (else
             (error "Invalid character in string")))))))