#lang racket
(require racket/hash)

(define (reward-top-k-students positive-feedback negative-feedback report student-id k)
  ;; 1. Preprocess feedback words into hash sets for efficient O(1) average-time lookup.
  ;; All words are converted to lowercase for case-insensitive matching.
  (define positive-set (make-hash-set (map string-downcase positive-feedback)))
  (define negative-set (make-hash-set (map string-downcase negative-feedback)))

  ;; 2. Calculate scores for each student.
  ;; The result is a list of (list student-id score) tuples.
  (define student-scores
    (for/list ([rep report]
               [id student-id])
      (let ([current-score 0])
        ;; Split the report into words and iterate through them.
        (for ([word (string-split rep)])
          (let ([lower-word (string-downcase word)])
            ;; Add 3 points for positive feedback words.
            (when (hash-set-contains? positive-set lower-word)
              (set! current-score (+ current-score 3)))
            ;; Subtract 1 point for negative feedback words.
            (when (hash-set-contains? negative-set lower-word)
              (set! current-score (- current-score 1))))))
        ;; Return the student's ID and their calculated score.
        (list id current-score))))

  ;; 3. Sort the students based on the specified criteria:
  ;;    - Primary: Score in descending order.
  ;;    - Secondary: Student ID in ascending order (for tie-breaking).
  (define sorted-students
    (sort student-scores
          (lambda (s1 s2)
            (let ([id1 (first s1)]
                  [score1 (second s1)]
                  [id2 (first s2)]
                  [score2 (second s2)])
              ;; Comparison logic:
              ;; If score1 > score2, s1 comes before s2.
              ;; If score1 < score2, s1 comes after s2.
              ;; If scores are equal, compare IDs: if id1 < id2, s1 comes before s2.
              (or (> score1 score2)
                  (and (= score1 score2)
                       (< id1 id2)))))))

  ;; 4. Extract the student IDs of the top K students from the sorted list.
  (map first (take sorted-students k)))