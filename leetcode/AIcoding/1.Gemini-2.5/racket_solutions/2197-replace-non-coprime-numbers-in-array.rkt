#lang racket

(define (replace-non-coprime-numbers nums)
  (let loop ((remaining-nums nums)
             (stack '())) ; stack stores numbers, with the most recent at the 'car' position
    (if (empty? remaining-nums)
        (reverse stack) ; The stack is built in reverse order of the final result
        (let* ((current-num (car remaining-nums))
               (next-remaining (cdr remaining-nums)))

          ;; Helper to process the current number by merging it with the stack
          ;; until it's coprime with the stack's top or the stack is empty.
          (let merge-and-push ((s stack) (val current-num))
            (if (and (not (empty? s))
                     (> (gcd (car s) val) 1)) ; Check if top of stack and current value are not coprime
                ;; Not coprime, merge them by calculating their LCM and continue merging
                (merge-and-push (cdr s) (lcm (car s) val))
                ;; Coprime or stack is empty, push the current value onto the stack
                (loop next-remaining (cons val s))))))))