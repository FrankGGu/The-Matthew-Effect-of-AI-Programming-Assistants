(define (distinct-subsequences-ii s)
  (define MOD 1000000007)
  (define dp 0) ; total distinct non-empty subsequences
  (define last-counts (make-vector 26 0)) ; last-counts[i] stores the number of distinct subsequences ending with (char (+ (char->integer #\a) i))

  (for-each
   (lambda (c)
     (define char-idx (- (char->integer c) (char->integer #\a)))

     ; Get the count of distinct subsequences ending with 'c' from its previous occurrences
     (define prev-char-count (vector-ref last-counts char-idx))

     ; Calculate the number of new distinct subsequences that can be formed ending with current 'c'
     ; This includes 'c' itself (1) and 'c' appended to all existing distinct subsequences (dp)
     (define new-char-count (add1 dp))

     ; Update the total number of distinct subsequences
     ; Add the new subsequences ending with 'c'
     ; Subtract 'prev-char-count' to remove duplicates that were already counted when 'c' appeared before
     (set! dp (+ dp new-char-count (- prev-char-count)))

     ; Apply modulo operation
     (set! dp (modulo dp MOD))

     ; Ensure the result is non-negative, as Racket's modulo can return negative for negative inputs
     (when (< dp 0) (set! dp (+ dp MOD)))

     ; Update last-counts for the current character 'c' with its new count
     (vector-set! last-counts char-idx (modulo new-char-count MOD)))
   (string->list s))

  dp)