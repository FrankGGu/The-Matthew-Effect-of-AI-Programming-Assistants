(define (max-product words)
  (define (has-common-chars? word1 word2)
    (define set1 (list->set (string->list word1)))
    (define set2 (list->set (string->list word2)))
    (not (set-empty? (set-intersect set1 set2))))

  (define (calculate-max-product words)
    (cond
      [(null? words) 0]
      [else (let loop ([max-prod 0] [remaining-words words])
              (cond
                [(null? remaining-words) max-prod]
                [else
                 (let ([current-word (car remaining-words)])
                   (let loop2 ([current-max max-prod] [other-words (cdr words)])
                     (cond
                       [(null? other-words) (loop (+ 0) (cdr remaining-words))]
                       [else
                        (let ([other-word (car other-words)])
                          (if (not (has-common-chars? current-word other-word))
                              (loop2 (max current-max (* (string-length current-word) (string-length other-word))) (cdr other-words))
                              (loop2 current-max (cdr other-words)))))])))]))]))

  (calculate-max-product words))