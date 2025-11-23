(define (two-edit-distance-dictionary dictionary query)
  (define (is-two-edits-away word1 word2)
    (define len1 (string-length word1))
    (define len2 (string-length word2))
    (when (> (abs (- len1 len2)) 2) #f)
    (define edits (list->vector (make-list (+ 1 (max len1 len2)) 0)))
    (define i 0)
    (define j 0)
    (define edit-count 0)
    (let loop ((i 0) (j 0) (edits 0))
      (cond
        ((>= i len1) (+ edits (- len2 j))) ; remaining characters in word2
        ((>= j len2) (+ edits (- len1 i))) ; remaining characters in word1
        (else
          (if (string-ref word1 i) = (string-ref word2 j)
            (loop (+ i 1) (+ j 1) edits)
            (if (= edits 2) #f ; already too many edits
              (loop (+ i 1) (+ j 1) (+ edits 1))))))))

  (filter (lambda (word) (is-two-edits-away word query)) dictionary))