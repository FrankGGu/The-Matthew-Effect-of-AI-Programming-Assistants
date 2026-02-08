#lang racket

(define (num-digits n)
  ;; Calculates the number of decimal digits in a positive integer n.
  ;; For this problem, n will always be >= 1.
  (let loop ((x n) (count 0))
    (if (= x 0) count
        (loop (quotient x 10) (add1 count)))))

(define (split-message message limit)
  (define L (string-length message))

  ;; Loop through possible number of digits 'd' for the total number of parts 'k'.
  ;; 'd' starts from 1.
  (let loop-d ((d 1))
    ;; Calculate the maximum suffix length for a 'k' with 'd' digits.
    ;; This assumes both 'idx' and 'total' have 'd' digits, which gives the longest suffix.
    ;; Suffix format: "<idx/total>"
    ;; Length: 1 (for '<') + num-digits(idx) + 1 (for '/') + num-digits(total) + 1 (for '>')
    ;; Max length occurs when num-digits(idx) = num-digits(total) = d.
    (define suf-len-d (+ 3 (* 2 d)))

    ;; Calculate the available content length per part, assuming the max suffix length.
    (define content-len-d (- limit suf-len-d))

    (if (<= content-len-d 0)
        ;; If content-len-d is non-positive, it means even with 'd' digits for 'k'
        ;; and maximum suffix length, we cannot fit any content.
        ;; Since suf-len-d only increases with 'd', it's impossible for any larger 'd' either.
        ;; Return an empty list as per problem statement.
        '()
        ;; Otherwise, try to find a suitable 'k' (total number of parts) for this 'd'.
        (let* (;; Calculate the minimum 'k' needed to hold all 'L' characters
               ;; if each part holds 'content-len-d' characters.
               (min-k-needed (ceiling (/ L content-len-d)))

               ;; Define the range of 'k' values that have 'd' digits.
               (k-min-d (expt 10 (- d 1))) ; e.g., for d=1, 10^0=1; for d=2, 10^1=10
               (k-max-d (sub1 (expt 10 d))) ; e.g., for d=1, 10^1-1=9; for d=2, 10^2-1=99

               ;; The candidate 'total' number of parts is the maximum of
               ;; the smallest 'k' with 'd' digits and the minimum 'k' required for content.
               (candidate-k (max k-min-d min-k-needed)))

          (if (<= candidate-k k-max-d)
              ;; If the candidate 'k' falls within the range of numbers with 'd' digits,
              ;; we have found the smallest valid 'total'.
              (let ((total candidate-k))
                ;; Now, construct the message parts.
                (let loop-parts ((i 1) (current-message-idx 0) (acc '()))
                  (if (> i total)
                      ;; All parts constructed, reverse the accumulator and return.
                      (reverse acc)
                      ;; Construct the current part.
                      (let* ((suffix (format "<~a/~a>" i total))
                             (suffix-len (string-length suffix))
                             ;; The actual content length for this specific part 'i'
                             ;; (suffix-len might be smaller than suf-len-d if i has fewer digits)
                             (part-content-len (- limit suffix-len))
                             ;; Ensure we don't read beyond the message length.
                             (end-idx (min L (+ current-message-idx part-content-len)))
                             (part-content (substring message current-message-idx end-idx)))
                        (loop-parts (add1 i)
                                    end-idx
                                    (cons (string-append part-content suffix) acc))))))
              ;; If candidate-k is greater than k-max-d, it means no 'k' with 'd' digits
              ;; can satisfy the conditions. Try with the next number of digits 'd+1'.
              (loop-d (add1 d)))))))