(define (count-complete-substrings s k)
  (let* ([n (string-length s)]
         [total-ans 0]
         [current-segment-start 0])
    (when (= n 0) (error "Empty string")) ; LeetCode usually ensures non-empty string, but good practice

    (for ([i (in-range 1 n)])
      (when (> (abs (- (char->integer (string-ref s i)) (char->integer (string-ref s (- i 1))))) k)
        ;; Found a break point, process the segment s[current-segment-start ... i-1]
        (let ([segment (substring s current-segment-start i)])
          (set! total-ans (+ total-ans (count-complete-in-segment segment k))))
        (set! current-segment-start i)))
    ;; Add the last segment
    (let ([segment (substring s current-segment-start n)])
      (set! total-ans (+ total-ans (count-complete-in-segment segment k))))
    total-ans))

(define (count-complete-in-segment s-seg k)
  (let* ([n-seg (string-length s-seg)]
         [segment-ans 0])
    (when (= n-seg 0) (error "Empty segment")) ; Should not happen with proper splitting of non-empty string

    ;; Iterate over possible number of distinct characters 'm'
    ;; m can be from 1 to 26 (alphabet size)
    (for ([m (in-range 1 27)]) ; m from 1 to 26 inclusive
      (let ([char-freq (make-vector 26 0)] ; frequency of each char (a-z) in current window
            [freq-of-freq (make-vector (+ n-seg 1) 0)] ; freq-of-freq[f] = number of chars with frequency f
            [distinct-chars 0] ; count of distinct characters in window
            [unique-freq-count 0] ; count of unique frequency values (e.g., if freqs are {1:2, 2:1}, unique-freq-count=2)
            [left 0])
        (for ([right (in-range n-seg)])
          (let* ([char-code (- (char->integer (string-ref s-seg right)) (char->integer #\a))]
                 [old-freq (vector-ref char-freq char-code)])

            ;; Update freq-of-freq for old-freq
            (when (> old-freq 0)
              (vector-set! freq-of-freq old-freq (- (vector-ref freq-of-freq old-freq) 1))
              (when (= (vector-ref freq-of-freq old-freq) 0)
                (set! unique-freq-count (- unique-freq-count 1))))

            ;; Update char-freq
            (vector-set! char-freq char-code (+ old-freq 1))
            (let ([new-freq (vector-ref char-freq char-code)])
              ;; Update distinct-chars
              (when (= old-freq 0)
                (set! distinct-chars (+ distinct-chars 1)))

              ;; Update freq-of-freq for new-freq
              (vector-set! freq-of-freq new-freq (+ (vector-ref freq-of-freq new-freq) 1))
              (when (= (vector-ref freq-of-freq new-freq) 1)
                (set! unique-freq-count (+ unique-freq-count 1))))

            ;; Shrink window from left if conditions are not met
            (let loop-shrink ()
              (when (and (<= left right) ; Ensure left pointer doesn't cross right
                         (or (> distinct-chars m)
                             (not (= unique-freq-count 1)) ; All chars must have same frequency
                             (let* ([min-c #\z]
                                    [max-c #\a]
                                    [found-char #f])
                               (for ([c-idx (in-range 26)])
                                 (when (> (vector-ref char-freq c-idx) 0)
                                   (let ([current-char (integer->char (+ c-idx (char->integer #\a)))])
                                     (set! min-c (min current-char min-c))
                                     (set! max-c (max current-char max-c))
                                     (set! found-char #t))))
                               (and found-char (> (- (char->integer max-c) (char->integer min-c)) k)))))
                (let* ([left-char-code (- (char->integer (string-ref s-seg left)) (char->integer #\a))]
                       [old-left-freq (vector-ref char-freq left-char-code)])

                  ;; Update freq-of-freq for old-left-freq
                  (vector-set! freq-of-freq old-left-freq (- (vector-ref freq-of-freq old-left-freq) 1))
                  (when (= (vector-ref freq-of-freq old-left-freq) 0)
                    (set! unique-freq-count (- unique-freq-count 1)))

                  ;; Update char-freq
                  (vector-set! char-freq left-char-code (- old-left-freq 1))
                  (let ([new-left-freq (vector-ref char-freq left-char-code)])
                    ;; Update distinct-chars
                    (when (= new-left-freq 0)
                      (set! distinct-chars (- distinct-chars 1)))

                    ;; Update freq-of-freq for new-left-freq
                    (when (> new-left-freq 0) ; only add if char is still present
                      (vector-set! freq-of-freq new-left-freq (+ (vector-ref freq-of-freq new-left-freq) 1))
                      (when (= (vector-ref freq-of-freq new-left-freq) 1)
                        (set! unique-freq-count (+ unique-freq-count 1)))))
                  (set! left (+ left 1))
                  (loop-shrink))))

            ;; After shrinking, if the window [left, right] is valid
            (when (and (= distinct-chars m)
                       (= unique-freq-count 1))
              ;; Find the common frequency
              (let ([common-freq (let loop-f ([f 1])
                                   (cond
                                     [(> f n-seg) -1] ; Should not happen if unique-freq-count is 1 and distinct-chars > 0
                                     [(> (vector-ref freq-of-freq f) 0) f]
                                     [else (loop-f (+ f 1))]))])
                (when (and (> common-freq 0)
                           (= (* m common-freq) (+ (- right left) 1))) ; Length check
                  (set! segment-ans (+ segment-ans 1))))))))
    segment-ans))