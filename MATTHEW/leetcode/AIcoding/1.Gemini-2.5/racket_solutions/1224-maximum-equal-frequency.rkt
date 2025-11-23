#lang racket

(define (max-equal-frequency nums)
  (define n (vector-length nums))
  (define counts (make-hash))         ; Maps number -> its frequency
  (define freq-counts (make-hash))    ; Maps frequency -> count of numbers with that frequency
  (define max-freq 0)                 ; Maximum frequency observed among any number
  (define max-len 0)

  (for ([i (in-range n)])
    (define num (vector-ref nums i))

    ; Update counts
    (define old-freq (hash-ref counts num 0))
    (define new-freq (+ old-freq 1))
    (hash-set! counts num new-freq)

    ; Update freq-counts
    (when (> old-freq 0)
      (hash-update! freq-counts old-freq sub1)
      (when (= (hash-ref freq-counts old-freq 0) 0)
        (hash-remove! freq-counts old-freq)))
    (hash-update! freq-counts new-freq add1 0)

    ; Update max-freq
    (set! max-freq (max max-freq new-freq))

    ; Check conditions for current prefix nums[0...i]
    (define num-distinct (hash-count counts))
    (define current-len (+ i 1))

    (when (or
           ; Condition 1: All elements have frequency 1 (e.g., [1,2,3,4])
           ; Remove any element, remaining elements still have frequency 1.
           (= max-freq 1)

           ; Condition 2: Only one distinct element (e.g., [1,1,1,1])
           ; Remove one instance of this element, remaining have frequency (max-freq - 1).
           (= num-distinct 1)

           ; Condition 3: All elements have frequency `max-freq`, except one element which has frequency 1.
           ; (e.g., [1,1,2,2,3] -> remove 3, then [1,1,2,2] has freq 2 for 1 and 2)
           (and (= (hash-count freq-counts) 2)
                (= (hash-ref freq-counts max-freq 0) (- num-distinct 1))
                (= (hash-ref freq-counts 1 0) 1))

           ; Condition 4: All elements have frequency `max-freq - 1`, except one element which has frequency `max-freq`.
           ; (e.g., [1,1,2,2,2] -> remove one 2, then [1,1,2,2] has freq 2 for 1 and 2)
           (and (= (hash-count freq-counts) 2)
                (= (hash-ref freq-counts max-freq 0) 1)
                (> max-freq 1) ; Ensure max-freq - 1 is a valid frequency
                (= (hash-ref freq-counts (- max-freq 1) 0) (- num-distinct 1))))
      (set! max-len current-len)))

  max-len)