(define (maximum-cost-substring s chars vals)
  ;; 1. Initialize character costs
  ;; Create a vector of size 26 to store costs for 'a' through 'z'.
  ;; Index 0 for 'a', 1 for 'b', ..., 25 for 'z'.
  (define char-costs (make-vector 26))

  ;; Set default costs: 'a' -> 1, 'b' -> 2, ..., 'z' -> 26
  (for ([i (in-range 26)])
    (vector-set! char-costs i (+ i 1)))

  ;; Override costs based on the 'chars' and 'vals' inputs
  (for ([i (in-range (string-length chars))])
    (define char-to-override (string-ref chars i))
    (define val-to-set (vector-ref vals i))
    ;; Calculate the 0-indexed position of the character ('a' is 0, 'b' is 1, etc.)
    (define char-idx (- (char->integer char-to-override) (char->integer #\a)))
    (vector-set! char-costs char-idx val-to-set))

  ;; 2. Convert the input string 's' into a list of its character costs
  (define s-length (string-length s))
  (define s-numeric-costs (make-vector s-length))
  (for ([i (in-range s-length)])
    (define current-char (string-ref s i))
    (define char-idx (- (char->integer current-char) (char->integer #\a)))
    (vector-set! s-numeric-costs i (vector-ref char-costs char-idx)))

  ;; 3. Apply Kadane's Algorithm to find the maximum subarray sum (maximum substring cost)
  (define max-so-far 0)     ; Stores the maximum sum found so far
  (define current-max 0)    ; Stores the maximum sum ending at the current position

  (for ([cost (in-vector s-numeric-costs)])
    (set! current-max (+ current-max cost))
    ;; If current-max becomes negative, reset it to 0.
    ;; This means starting a new substring from the next element is better
    ;; than extending the current one. An empty substring has cost 0.
    (when (< current-max 0)
      (set! current-max 0))
    ;; Update max-so-far if current-max is greater
    (set! max-so-far (max max-so-far current-max)))

  max-so-far)