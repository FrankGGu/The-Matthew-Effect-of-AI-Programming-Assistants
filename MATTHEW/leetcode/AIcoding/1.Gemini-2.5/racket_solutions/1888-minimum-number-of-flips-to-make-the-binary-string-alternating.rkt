#lang racket

(define (min-flips s)
  (let* ((n (string-length s))
         (s-double (string-append s s))
         (min-overall (add1 n))) ; Initialize with a value larger than any possible flip count

    (when (= n 1)
      (set! min-overall 0)) ; A single character string is always alternating.

    (when (> n 1)
      (let ((flips-to-0-start 0) ; Flips needed for 0101... pattern starting with 0
            (flips-to-1-start 0)) ; Flips needed for 1010... pattern starting with 1

        ; Calculate initial flips for the first window s[0...n-1]
        (for ([k (in-range n)])
          (let* ((char-at-k (string-ref s-double k))
                 (expected-0 (if (even? k) #\0 #\1))
                 (expected-1 (if (even? k) #\1 #\0)))
            (unless (char-=? char-at-k expected-0)
              (set! flips-to-0-start (add1 flips-to-0-start)))
            (unless (char-=? char-at-k expected-1)
              (set! flips-to-1-start (add1 flips-to-1-start)))))

        (set! min-overall (min min-overall flips-to-0-start flips-to-1-start))

        ; Slide the window
        (for ([i (in-range 1 n)]) ; i is the starting index of the current window
          ; Character leaving the window: s-double[i-1]
          (let* ((char-leaving (string-ref s-double (sub1 i)))
                 (expected-0-leaving #\0) ; Expected at relative index 0 for 0101...
                 (expected-1-leaving #\1)) ; Expected at relative index 0 for 1010...

            (unless (char-=? char-leaving expected-0-leaving)
              (set! flips-to-0-start (sub1 flips-to-0-start)))
            (unless (char-=? char-leaving expected-1-leaving)
              (set! flips-to-1-start (sub1 flips-to-1-start))))

          ; After removing char-leaving, the remaining n-1 characters shift their relative indices.
          ; This means their expected alternating pattern flips.
          ; If it was 0101... for these chars, it becomes 1010...
          ; If it was 1010... for these chars, it becomes 0101...
          ; So, the new flips-to-0-start for these n-1 chars is old flips-to-1-start.
          ; And new flips-to-1-start for these n-1 chars is old flips-to-0-start.
          (let ((f0-for-middle flips-to-1-start)
                (f1-for-middle flips-to-0-start))

            ; Character entering the window: s-double[i+n-1]
            (let* ((char-entering (string-ref s-double (+ i n -1)))
                   (expected-0-entering (if (even? (sub1 n)) #\0 #\1)) ; Expected at relative index n-1 for 0101...
                   (expected-1-entering (if (even? (sub1 n)) #\1 #\0))) ; Expected at relative index n-1 for 1010...

              (unless (char-=? char-entering expected-0-entering)
                (set! f0-for-middle (add1 f0-for-middle)))
              (unless (char-=? char-entering expected-1-entering)
                (set! f1-for-middle (add1 f1-for-middle))))

            (set! flips-to-0-start f0-for-middle)
            (set! flips-to-1-start f1-for-middle))

          (set! min-overall (min min-overall flips-to-0-start flips-to-1-start)))))

    min-overall))