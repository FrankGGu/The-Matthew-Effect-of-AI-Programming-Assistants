#lang racket

(require racket/set)

(define (naming-a-company ideas)
  (define groups (make-hash)) ; char -> set of strings (suffixes)

  ;; Initialize groups for 'a' through 'z' with empty sets
  (for ([i (in-range 26)])
    (hash-set! groups (integer->char (+ (char->integer #\a) i)) (set)))

  ;; Populate groups with suffixes
  (for ([idea ideas])
    (define first-char (string-ref idea 0))
    (define suffix (substring idea 1))
    (hash-set! groups first-char (set-add (hash-ref groups first-char) suffix)))

  (define total-pairs 0)

  ;; Iterate through all unique pairs of distinct characters (c1, c2)
  (for ([i (in-range 26)])
    (define c1 (integer->char (+ (char->integer #\a) i)))
    (define set1 (hash-ref groups c1))
    (for ([j (in-range (+ i 1) 26)]) ; j starts from i+1 to avoid duplicates and self-pairs
      (define c2 (integer->char (+ (char->integer #\a) j)))
      (define set2 (hash-ref groups c2))

      ;; Find common suffixes between the two sets
      (define common-suffixes (set-intersect set1 set2))

      ;; Calculate unique suffixes for each character group
      (define count-unique1 (- (set-count set1) (set-count common-suffixes)))
      (define count-unique2 (- (set-count set2) (set-count common-suffixes)))

      ;; Add to total pairs. Each pair (idea_A, idea_B) and (idea_B, idea_A) are distinct.
      ;; So, multiply by 2.
      (set! total-pairs (+ total-pairs (* 2 count-unique1 count-unique2)))))

  total-pairs)