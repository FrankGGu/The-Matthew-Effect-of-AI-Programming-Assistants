(define (min-window s t)
  (let* ([s-len (string-length s)]
         [t-len (string-length t)])

    (cond
      ;; If t is empty, an empty string is the smallest valid window.
      [(zero? t-len) ""]
      ;; If s is empty, no window can be found.
      [(zero? s-len) ""]
      [else
       ;; t-map stores the required character counts for string t.
       (define t-map (make-hash))
       (for ([char (in-string t)])
         (hash-set! t-map char (add1 (hash-ref t-map char 0))))

       ;; window-map stores the character counts for the current sliding window in s.
       (define window-map (make-hash))

       (define left 0)
       ;; matched-chars tracks the number of characters from t (including duplicates)
       ;; that are still needed to form a valid window.
       ;; When matched-chars becomes 0, the current window is valid.
       (define matched-chars t-len)
       (define min-len (+inf.0)) ; Stores the length of the smallest valid window found so far.
       (define min-start 0)      ; Stores the starting index of the smallest valid window.

       ;; Iterate with the right pointer to expand the window.
       (for ([right (in-range s-len)])
         (define char-right (string-ref s right))

         ;; If char-right is a character required by t.
         (when (hash-has-key? t-map char-right)
           (let ([t-count (hash-ref t-map char-right)])
             ;; Increment the count of char-right in the window.
             (hash-set! window-map char-right (add1 (hash-ref window-map char-right 0)))
             ;; If the current count of char-right in the window is now less than or
             ;; equal to its required count in t, it means we've satisfied one more
             ;; instance of a needed character.
             (when (<= (hash-ref window-map char-right) t-count)
               (set! matched-chars (sub1 matched-chars)))))

         ;; While the current window is valid (all characters from t are matched).
         (let loop-shrink ([current-left left])
           (when (and (zero? matched-chars) ; All required characters are present.
                      (<= current-left right)) ; Ensure left pointer doesn't cross right.
             ;; Calculate the length of the current valid window.
             (let ([current-len (add1 (- right current-left))])
               ;; If this window is smaller than the smallest found so far, update.
               (when (< current-len min-len)
                 (set! min-len current-len)
                 (set! min-start current-left)))

             (define char-left (string-ref s current-left))

             ;; If char-left is a character required by t.
             (when (hash-has-key? t-map char-left)
               (let ([t-count (hash-ref t-map char-left)])
                 ;; If removing this char-left would make its count in the window
                 ;; exactly equal to its required count in t (meaning it was previously
                 ;; in excess or just met the requirement), then we are about to become
                 ;; deficient for one character.
                 (when (= (hash-ref window-map char-left) t-count)
                   (set! matched-chars (add1 matched-chars)))
                 ;; Decrement the count of char-left in the window.
                 (hash-set! window-map char-left (sub1 (hash-ref window-map char-left)))))

             ;; Move the left pointer to shrink the window.
             (set! left (add1 current-left))
             ;; Continue shrinking if the window is still valid.
             (loop-shrink left))))

       ;; After iterating through s, if min-len is still +inf.0, no valid window was found.
       (if (= min-len +inf.0)
           ""
           ;; Otherwise, return the smallest window found.
           (substring s min-start (+ min-start min-len)))])))