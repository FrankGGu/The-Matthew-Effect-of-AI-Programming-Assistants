(define/contract (sort-sentence s)
  (-> string? string?)
  (let* ([words (string-split s)]
         [sorted-words (sort words (lambda (a b)
                                     (< (string->number (substring a (- (string-length a) 1)))
                                        (string->number (substring b (- (string-length b) 1)))))]
         [processed-words (map (lambda (word) (substring word 0 (- (string-length word) 1))) sorted-words)])
    (string-join processed-words " ")))