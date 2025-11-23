#lang racket

(define (min-stickers stickers target)
  ;; Helper to convert a character to its 0-25 integer index
  (define (char->int c) (- (char->integer c) (char->integer #\a)))

  ;; Converts a string to a frequency list (list of 26 integers)
  (define (string->counts s)
    (for/fold ([counts (make-list 26 0)])
              ([c (string->list s)])
      (let ([idx (char->int c)])
        (list-set counts idx (+ (list-ref counts idx) 1)))))

  ;; Calculate target word frequency counts
  (define target-counts (string->counts target))

  ;; Pre-process stickers:
  ;; 1. Convert each sticker string to its frequency counts.
  ;; 2. Filter out characters from stickers that are not present in the target word.
  ;;    This prevents using sticker characters that are irrelevant to the target.
  ;; 3. Remove duplicate sticker count lists to avoid redundant computations.
  (define filtered-sticker-counts-list
    (let ([target-char-indices (filter (lambda (i) (> (list-ref target-counts i) 0)) (in-range 26))]
          [raw-sticker-counts (map string->counts stickers)])
      (remove-duplicates
       (map (lambda (sticker-c)
              (for/list ([i (in-range 26)])
                (if (member i target-char-indices) ; Check if this char index is relevant to target
                    (list-ref sticker-c i)
                    0)))
            raw-sticker-counts)
       equal?)))

  ;; Memoization table: maps (list of 26 ints representing remaining target counts) -> minimum stickers needed
  (define memo (make-hash))

  ;; Recursive function to find the minimum stickers for the current remaining target counts
  (define (solve current-target-counts)
    ;; 1. Check if this state has already been computed
    (cond
      [(hash-has-key? memo current-target-counts)
       (hash-ref memo current-target-counts)]
      ;; 2. Base case: If all characters in the target have been spelled (all counts are 0)
      [(andmap (lambda (x) (= x 0)) current-target-counts)
       0]
      ;; 3. Recursive step: Try applying each sticker
      [else
       (let* ([min-stickers-needed +inf.0]
              ;; Find the first character that still needs to be spelled.
              ;; This is a crucial optimization: we only consider stickers that can help with this specific character.
              [first-char-idx (for/first ([i (in-range 26)]
                                          #:when (> (list-ref current-target-counts i) 0))
                                i)])

         ;; 'first-char-idx' will always be a number here because the base case handles all-zero counts.
         (for ([sticker-c filtered-sticker-counts-list])
           ;; Optimization: Only consider stickers that contain the 'first-char-idx' character.
           (when (> (list-ref sticker-c first-char-idx) 0)
             (let* ([next-target-counts
                     (for/list ([i (in-range 26)])
                       (let* ([target-val (list-ref current-target-counts i)]
                              [sticker-val (list-ref sticker-c i)])
                         ;; Reduce target count by sticker count, but not below zero
                         (max 0 (- target-val sticker-val))))]
                    ;; Check if the sticker actually reduced any character count.
                    ;; If not, applying it is useless and leads to infinite recursion or redundant states.
                    [sticker-applied? (not (equal? next-target-counts current-target-counts))])

               (when sticker-applied?
                 (let ([res (solve next-target-counts)])
                   ;; If 'res' is not +inf.0 (meaning a solution was found down this path)
                   (when (not (= res +inf.0))
                     (set! min-stickers-needed (min min-stickers-needed (+ 1 res))))))))))

         ;; Store the computed result in the memoization table before returning
         (hash-set! memo current-target-counts min-stickers-needed)
         min-stickers-needed)))

  ;; Start the recursion with the initial target counts
  (let ([result (solve target-counts)])
    ;; If the final result is still +inf.0, it means it's impossible to spell the word
    (if (= result +inf.0) -1 result)))