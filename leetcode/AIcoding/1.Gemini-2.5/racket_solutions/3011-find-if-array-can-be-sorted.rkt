#lang racket

(define (array-can-be-sorted? nums)
  (define n (length nums))
  (if (<= n 1) #t)

  (define (popcount n) (bitwise-popcount n))

  (define segments '()) ; List of lists (segments), built in reverse order
  (define current-segment '()) ; Accumulator for the current segment, built in reverse order

  (define first-val (first nums))
  (define current-popcount (popcount first-val))
  (set! current-segment (cons first-val current-segment)) ; Start with the first element

  (for ([x (rest nums)]) ; Iterate from the second element
    (define x-popcount (popcount x))
    (if (= x-popcount current-popcount)
        (set! current-segment (cons x current-segment))
        (begin
          ; A new segment starts, so finalize the current one
          (set! segments (cons (reverse current-segment) segments))
          (set! current-segment (list x)) ; Start the new segment with x
          (set! current-popcount x-popcount))))
  ; Add the last segment
  (set! segments (cons (reverse current-segment) segments))
  (set! segments (reverse segments)) ; Reverse the list of segments to get the correct order

  ; Now, sort each segment and flatten them into a single list
  (define sorted-flattened-segments (apply append (map (lambda (seg) (sort seg <)) segments)))

  ; Check if the combined list of sorted segments is itself sorted
  (let check-sorted ((lst sorted-flattened-segments))
    (cond
      ((or (empty? lst) (empty? (rest lst))) #t) ; 0 or 1 element, considered sorted
      ((> (first lst) (second lst)) #f) ; Not sorted
      (else (check-sorted (rest lst))))))