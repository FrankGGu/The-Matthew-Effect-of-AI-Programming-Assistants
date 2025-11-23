(define (find-and-replace s indices sources targets)
  (define s-len (string-length s))

  ;; Combine indices, sources, and targets into a list of replacement specifications.
  ;; Each spec is a list: (list index source target)
  (define replacement-specs
    (map list indices sources targets))

  ;; Sort the replacement specifications by their index in ascending order.
  (define sorted-replacements
    (sort replacement-specs
          (lambda (a b) (< (car a) (car b))))) ; Sort by index (car of inner list)

  ;; Use foldl to process the sorted replacements and build the result string parts.
  ;; The accumulator holds two values:
  ;; 1. A list of string parts accumulated so far.
  ;; 2. The index in the original string `s` from which the next segment should be copied.
  (define-values (final-parts final-last-s-idx)
    (foldl (lambda (spec acc)
             (define current-parts (car acc))
             (define last-s-idx (cdr acc))
             (define idx (car spec))
             (define src (cadr spec))
             (define tgt (caddr spec))
             (define src-len (string-length src))

             ;; Append the segment of 's' from 'last-s-idx' up to 'idx'
             ;; This covers parts of 's' that are not affected by replacements
             ;; or parts where a previous replacement attempt failed.
             (define parts-with-pre-segment
               (append current-parts (list (substring s last-s-idx idx))))

             ;; Check if the source string actually matches the substring in 's'
             ;; at the specified index. Also ensure it's within bounds.
             (if (and (<= (+ idx src-len) s-len)
                      (string=? (substring s idx (+ idx src-len)) src))
                 ;; If there's a match, append the target string and advance
                 ;; 'last-s-idx' past the replaced source string.
                 (values (append parts-with-pre-segment (list tgt))
                         (+ idx src-len))
                 ;; If no match, no replacement occurs. The original characters
                 ;; will be copied later (either by a subsequent pre-segment or the final tail).
                 ;; 'last-s-idx' remains unchanged.
                 (values parts-with-pre-segment
                         last-s-idx)))
           (values '() 0) ; Initial accumulator: empty parts list, start at index 0
           sorted-replacements))

  ;; After processing all replacements, append any remaining tail of 's'
  ;; from 'final-last-s-idx' to the end of the string.
  (define all-parts
    (append final-parts (list (substring s final-last-s-idx s-len))))

  ;; Join all accumulated string parts into a single result string.
  (string-append* all-parts))