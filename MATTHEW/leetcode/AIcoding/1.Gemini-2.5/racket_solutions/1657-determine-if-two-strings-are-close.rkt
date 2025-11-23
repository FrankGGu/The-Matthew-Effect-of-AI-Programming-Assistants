#lang racket

(define (get-char-info s)
  (let ([freqs (make-hash)]
        [chars (set)])
    (for ([c (string->list s)])
      (hash-update! freqs c add1 0)
      (set-add! chars c))
    (values freqs chars)))

(define (close-strings word1 word2)
  (let* ([len1 (string-length word1)]
         [len2 (string-length word2)])

    (unless (= len1 len2)
      #f)

    (let-values ([(freqs1 chars1) (get-char-info word1)]
                 [(freqs2 chars2) (get-char-info word2)])

      (unless (set=? chars1 chars2)
        #f)

      (let* ([freq-list1 (sort (hash-values freqs1) <)]
             [freq-list2 (sort (hash-values freqs2) <)])
        (equal? freq-list1 freq-list2)))))