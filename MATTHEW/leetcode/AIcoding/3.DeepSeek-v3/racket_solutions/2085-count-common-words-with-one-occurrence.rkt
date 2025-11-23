(define (count-words words1 words2)
  (define (count lst)
    (let loop ([lst lst] [ht (make-hash)])
      (if (null? lst)
          ht
          (let ([word (car lst)])
            (hash-update! ht word (lambda (x) (+ x 1)) 0)
            (loop (cdr lst) ht)))))

  (let* ([ht1 (count words1)]
         [ht2 (count words2)]
         [common-words (filter (lambda (word) (and (hash-has-key? ht1 word) (hash-has-key? ht2 word)))
                               (append words1 words2))]
         [unique-common-words (remove-duplicates common-words)])
    (length (filter (lambda (word) (and (= (hash-ref ht1 word) 1) (= (hash-ref ht2 word) 1)))
                    unique-common-words))))