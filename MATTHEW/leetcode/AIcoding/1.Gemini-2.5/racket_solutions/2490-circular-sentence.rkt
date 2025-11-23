(define (is-circular-sentence sentence)
  (let* ((words (string-split sentence " "))
         (n (length words)))
    (if (= n 0)
        #f
        (let ((all-adjacent-match?
               (for/and ((i (in-range (- n 1))))
                 (let* ((word1 (list-ref words i))
                        (word2 (list-ref words (+ i 1))))
                   (char=? (string-ref word1 (- (string-length word1) 1))
                           (string-ref word2 0)))))
              (circular-match?
               (let* ((first-word (list-ref words 0))
                      (last-word (list-ref words (- n 1))))
                 (char=? (string-ref last-word (- (string-length last-word) 1))
                         (string-ref first-word 0)))))
          (and all-adjacent-match? circular-match?)))))