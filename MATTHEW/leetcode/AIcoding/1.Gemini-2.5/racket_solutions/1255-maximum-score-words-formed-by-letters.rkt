(define (max-score-words words letters score)

  (define (char->idx c)
    (- (char->integer c) (char->integer #\a)))

  ;; Initial letter counts (using a vector)
  (define initial-counts (make-vector 26 0))
  (for-each (lambda (c)
              (vector-set! initial-counts (char->idx c)
                           (+ (vector-ref initial-counts (char->idx c)) 1)))
            letters)

  ;; Pre-process words to their character counts and individual scores
  ;; Each element in word-data will be a list: (vector-of-char-counts word-score)
  (define word-data
    (map (lambda (word)
           (let ((word-char-counts (make-vector 26 0))
                 (word-score 0))
             (for-each (lambda (c)
                         (let ((idx (char->idx c)))
                           (vector-set! word-char-counts idx
                                        (+ (vector-ref word-char-counts idx) 1))
                           (set! word-score (+ word-score (list-ref score idx)))))
                       (string->list word))
             (list word-char-counts word-score)))
         words))

  ;; Helper to check if a word can be formed
  (define (can-form-word? word-counts available-counts)
    (for/and ([i (in-range 26)])
      (>= (vector-ref available-counts i) (vector-ref word-counts i))))

  ;; Helper to create new counts after subtracting (returns a new vector)
  (define (subtract-counts available-counts word-counts)
    (let ((new-counts (make-vector 26)))
      (for ([i (in-range 26)])
        (vector-set! new-counts i
                     (- (vector-ref available-counts i) (vector-ref word-counts i))))
      new-counts))

  ;; Recursive DFS function
  (define (dfs idx current-counts)
    (if (= idx (length words))
        0
        (let* ((current-word-data (list-ref word-data idx))
               (current-word-char-counts (list-ref current-word-data 0))
               (current-word-score (list-ref current-word-data 1)))

          ;; Option 1: Don't include the current word
          (define score-without-word (dfs (+ idx 1) current-counts))

          ;; Option 2: Try to include the current word
          (define score-with-word
            (if (can-form-word? current-word-char-counts current-counts)
                (+ current-word-score
                   (dfs (+ idx 1) (subtract-counts current-counts current-word-char-counts)))
                0))

          (max score-without-word score-with-word))))

  (dfs 0 initial-counts))