#lang racket

(define (next-greater-element-iv nums)
  (define n (vector-length nums))
  (define ans (make-vector n -1))

  (define s1 '()) ; Stack for first greater element candidates (indices), decreasing order of nums[idx]
  (define s2 '()) ; Stack for second greater element candidates (indices), decreasing order of nums[idx]

  (for ([i (in-range n)])
    (define current-num (vector-ref nums i))

    ; Process s2: find second greater element
    ; Elements in s2 are waiting for their second greater element.
    ; Pop elements from s2 whose value is less than current-num.
    ; These popped elements found their second greater element.
    (let loop-s2 ()
      (when (and (not (empty? s2)) (< (vector-ref nums (car s2)) current-num))
        (vector-set! ans (car s2) current-num)
        (set! s2 (cdr s2))
        (loop-s2)))

    ; Process s1: find first greater element and move to s2 candidates
    ; Elements in s1 are waiting for their first greater element.
    ; Pop elements from s1 whose value is less than current-num.
    ; These popped elements found their first greater, and become candidates for s2.
    (define temp-for-s2 '()) ; Collects indices popped from s1
    (let loop-s1 ()
      (when (and (not (empty? s1)) (< (vector-ref nums (car s1)) current-num))
        (set! temp-for-s2 (cons (car s1) temp-for-s2))
        (set! s1 (cdr s1))
        (loop-s1)))

    ; Add current index to s1
    (set! s1 (cons i s1))

    ; Add elements from temp-for-s2 to s2.
    ; temp-for-s2 was built by cons-ing, so it's `(idx_k ... idx_1)` where `idx_1` was popped first (smallest value).
    ; We need to add them to s2 such that s2 remains decreasing (nums[top] >= nums[next]).
    ; This means pushing `idx_1`, then `idx_2`, ..., then `idx_k`.
    ; So, we iterate `(reverse temp-for-s2)`.
    (for ([idx (in-list (reverse temp-for-s2))])
      (set! s2 (cons idx s2)))
    )

  ans)