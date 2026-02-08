#lang racket

(define (stamping-the-sequence stamp target)
  (let* ((n (string-length target))
         (m (string-length stamp))
         (target-vec (string->vector target))
         (stamp-vec (string->vector stamp))
         (q-char #\?)
         (q-count 0)
         (result '()))

    (define (match-and-replace! start-idx)
      (let ((non-q-chars-in-segment 0))
        (let loop-check ((k 0) (is-match #t))
          (cond
            ((not is-match) 0) ; Mismatch found, cannot unstamp
            ((= k m) ; All characters checked, it's a potential match
             (if (> non-q-chars-in-segment 0) ; Only replace if there's at least one non-'?'
                 (begin
                   ;; Perform replacement and count actual replaced non-'?'
                   (let ((actual-replaced 0))
                     (for ((j (in-range m)))
                       (unless (char=? (vector-ref target-vec (+ start-idx j)) q-char)
                         (set! actual-replaced (+ actual-replaced 1))
                         (vector-set! target-vec (+ start-idx j) q-char)))
                     actual-replaced))
                 0)) ; All '?'s, no useful replacement
            (else
             (let ((target-char (vector-ref target-vec (+ start-idx k)))
                   (stamp-char (vector-ref stamp-vec k)))
               (unless (char=? target-char q-char)
                 (set! non-q-chars-in-segment (+ non-q-chars-in-segment 1)))
               (loop-check (+ k 1)
                           (and is-match
                                (or (char=? target-char q-char)
                                    (char=? target-char stamp-char)))))))))

    (let outer-loop ()
      (when (< q-count n) ; Continue as long as not all characters are '?'
        (let ((found-unstamp-in-this-iteration #f))
          ;; Iterate through all possible starting positions for the stamp
          (for ((i (in-range (+ (- n m) 1))))
            (let ((replaced-count (match-and-replace! i)))
              (when (> replaced-count 0)
                (set! q-count (+ q-count replaced-count))
                (set! result (cons i result)) ; Add index to the front of the list
                (set! found-unstamp-in-this-iteration #t))))

          (if found-unstamp-in-this-iteration
              (outer-loop) ; If progress was made, try again
              '())))) ; No progress, impossible to complete, return empty list

    ;; After the loop, check if all characters were successfully replaced with '?'
    (if (= q-count n)
        (reverse result) ; Reverse the list to get the original stamping order
        '())))