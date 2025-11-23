#lang racket

(define (get-folder-names names)
  (define seen-names (make-hash))      ; Stores all final unique names (string -> #t)
  (define name-counters (make-hash))   ; Stores next suffix k for a given base name (string -> integer)

  (define result-list '())             ; Accumulator for the final list, built in reverse

  (for-each
   (lambda (name)
     (let ((final-name name))
       (if (hash-has-key? seen-names name)
           ; The original name 'name' is already taken.
           ; We need to find a unique 'name(k)'.
           (let loop ((k (hash-ref name-counters name 1))) ; Start with k=1 if name never needed a suffix, else use stored k
             (let ((candidate-name (string-append name "(" (number->string k) ")")))
               (if (hash-has-key? seen-names candidate-name)
                   ; Candidate name is also taken, try next k
                   (begin
                     (hash-set! name-counters name (add1 k)) ; Update counter for original base name
                     (loop (add1 k)))
                   ; Candidate name is unique
                   (begin
                     (set! final-name candidate-name)
                     (hash-set! name-counters name (add1 k)))))) ; Update counter for original base name
           ; The original name 'name' is unique.
           ; No need to do anything with final-name, it's already 'name'.
           )

       ; Now final-name holds the unique name to add to the result.
       (set! result-list (cons final-name result-list))
       (hash-set! seen-names final-name #t)

       ; Ensure that the counter for 'name' (the original input string) is initialized/updated.
       ; This is crucial for when 'name' itself was unique, but might be repeated later.
       (when (not (hash-has-key? name-counters name))
         (hash-set! name-counters name 1))
       ))
   names)

  (reverse result-list))