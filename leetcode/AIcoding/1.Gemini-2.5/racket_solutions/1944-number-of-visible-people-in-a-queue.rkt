#lang racket

(define (visible-people heights)
  (let loop ([remaining-heights (reverse heights)] ; Process people from right to left
             [stack '()]                          ; Monotonic stack (stores heights of people to the right)
             [result-accumulator '()])            ; Accumulates results (ans[0] ... ans[n-1])
    (if (empty? remaining-heights)
        ; Base case: all people processed.
        ; The result-accumulator is built in the correct order (ans[0] to ans[n-1]).
        result-accumulator

        (let* ([current-height (car remaining-heights)]
               [next-remaining-heights (cdr remaining-heights)])

          ; Inner loop to process the stack for the current person
          (let pop-and-count ([s stack] [count 0])
            (if (and (not (empty? s)) (<= (car s) current-height))
                ; If the person on top of the stack is shorter than or equal to the current person,
                ; the current person can see them. Pop them and increment count.
                (pop-and-count (cdr s) (+ count 1))

                ; Stack is empty OR the person on top of the stack is taller than the current person.
                ; This is where the popping stops.
                (let ([final-count (if (not (empty? s)) (+ count 1) count)])
                  ; If the stack is not empty, it means the person at (car s) is taller than current-height.
                  ; This person is also visible to the current person, so increment count by 1.
                  ; If the stack is empty, no one taller was found, so count remains as is.

                  ; Push the current person's height onto the stack for future people to consider.
                  ; Prepend the calculated final-count to the result-accumulator.
                  (loop next-remaining-heights (cons current-height s) (cons final-count result-accumulator)))))))))