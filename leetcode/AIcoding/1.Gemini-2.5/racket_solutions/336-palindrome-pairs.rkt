#lang racket

(require racket/hash)
(require racket/set)
(require racket/string)

(define (is-palindrome? s)
  (string=? s (string-reverse s)))

(define (palindrome-pairs words)
  (define word-to-index (make-hash))
  (for ((word words) (i (in-naturals)))
    (hash-set! word-to-index word i))

  (define results (set)) ; Using a set to store unique pairs (lists of 2 integers)

  (for ((word words) (i (in-naturals)))
    (define len (string-length word))
    (define rev-word (string-reverse word))

    ;; Case 1: word + reverse(word) or reverse(word) + word
    ;; Example: If words = ["abc", "cba"], then "abc" + "cba" = "abccba" is a palindrome.
    (when (hash-has-key? word-to-index rev-word)
      (define j (hash-ref word-to-index rev-word))
      (when (not (= i j)) ; Ensure distinct indices
        (set! results (set-add results (list i j)))))

    ;; Case 2: Split word into left + right
    ;; We iterate through all possible split points k, such that both left and right are non-empty.
    ;; k ranges from 1 to len-1.
    (for ((k (in-range 1 len)))
      (define left (substring word 0 k))
      (define right (substring word k len))

      ;; Subcase 2a: If 'left' part is a palindrome, we need 'reverse(right)' to exist in words.
      ;; This forms (reverse(right) + word) which is (reverse(right) + left + right).
      ;; If 'left' is a palindrome, then (reverse(right) + left + right) is a palindrome.
      ;; Example: word = "aace", left = "aa", right = "ce". reverse(right) = "ec".
      ;; If "ec" is in words at index j, then (j, i) is a pair ("ec" + "aace" = "ecaace").
      (when (is-palindrome? left)
        (define rev-right (string-reverse right))
        (when (hash-has-key? word-to-index rev-right)
          (define j (hash-ref word-to-index rev-right))
          (set! results (set-add results (list j i))))) ; (other_word, word)

      ;; Subcase 2b: If 'right' part is a palindrome, we need 'reverse(left)' to exist in words.
      ;; This forms (word + reverse(left)) which is (left + right + reverse(left)).
      ;; If 'right' is a palindrome, then (left + right + reverse(left)) is a palindrome.
      ;; Example: word = "ecaa", left = "ec", right = "aa". reverse(left) = "ce".
      ;; If "ce" is in words at index j, then (i, j) is a pair ("ecaa" + "ce" = "ecaace").
      (when (is-palindrome? right)
        (define rev-left (string-reverse left))
        (when (hash-has-key? word-to-index rev-left)
          (define j (hash-ref word-to-index rev-left))
          (set! results (set-add results (list i j))))))) ; (word, other_word)

  (set->list results))