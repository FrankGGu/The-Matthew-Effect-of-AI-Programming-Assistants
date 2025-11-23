(require srfi/13) ; For string-ref, string-length
(require racket/string) ; For string-builder

(define (add-spaces s spaces)
  (let* ((len (string-length s))
         (sb (open-string-builder))
         (space-ptr spaces)) ; Use a pointer to the spaces list for efficient traversal
    (for ([i (in-range len)])
      ;; Check if a space needs to be inserted before the current character s[i]
      (when (and (not (empty? space-ptr))
                 (= i (car space-ptr)))
        (string-builder-add-char! sb #\space)
        (set! space-ptr (cdr space-ptr)))
      ;; Append the current character from the original string
      (string-builder-add-char! sb (string-ref s i)))
    ;; Convert the string-builder content to a final string
    (string-builder-get-string sb)))