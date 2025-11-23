#lang racket

(define (get-max-repetitions s1 n1 s2 n2)
  (let* ([s1-len (string-length s1)]
         [s2-len (string-length s2)]
         [memo (make-vector (add1 s2-len) #f)] ; Stores (s1_count . s2_count) for each s2_idx
         [s1-count 0] ; Number of s1 blocks processed
         [s2-count 0] ; Number of s2 blocks fully matched
         [s2-idx 0])  ; Current index in s2 for matching

    (let loop ()
      (when (< s1-count n1)
        (let ([memo-entry (vector-ref memo s2-idx)])
          (when memo-entry ; Cycle detected
            (let* ([prev-s1-count (car memo-entry)]
                   [prev-s2-count (cdr memo-entry)]
                   [cycle-s1-len (- s1-count prev-s1-count)]
                   [cycle-s2-len (- s2-count prev-s2-count)])

              (let* ([remaining-s1-blocks (- n1 s1-count)]
                     [num-cycles (quotient remaining-s1-blocks cycle-s1-len)])
                (set! s2-count (+ s2-count (* num-cycles cycle-s2-len)))
                (set! s1-count (+ s1-count (* num-cycles cycle-s1-len))))
              (loop))) ; After jumping, re-evaluate loop condition. If s1-count >= n1, it will terminate.

          ; Only proceed with recording and simulating if s1-count is still less than n1
          (unless (>= s1-count n1)
            ; Record current state before processing this s1 block
            (vector-set! memo s2-idx (cons s1-count s2-count))

            ; Simulate matching one s1 block
            (for ([s1-char-idx (in-range s1-len)])
              (when (char=? (string-ref s1 s1-char-idx) (string-ref s2 s2-idx))
                (set! s2-idx (add1 s2-idx))
                (when (= s2-idx s2-len)
                  (set! s2-count (add1 s2-count))
                  (set! s2-idx 0))))
            (set! s1-count (add1 s1-count))
            (loop))))) ; Continue to next iteration if s1-count < n1

    (loop) ; Start the loop

    (quotient s2-count n2)))