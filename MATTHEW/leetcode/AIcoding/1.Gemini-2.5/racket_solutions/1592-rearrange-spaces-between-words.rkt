(define (rearrange-spaces text)
  (let* ([words (filter (lambda (s) (> (string-length s) 0)) (string-split text #\space))]
         [num-words (length words)]
         [total-spaces (- (string-length text) (apply + (map string-length words)))])

    (cond
      [(= num-words 1)
       (string-append (car words) (make-string total-spaces #\space))]
      [else ; num-words > 1
       (let* ([num-gaps (- num-words 1)]
              [spaces-per-gap (quotient total-spaces num-gaps)]
              [trailing-spaces (remainder total-spaces num-gaps)]
              [gap-string (make-string spaces-per-gap #\space)])
         (string-append
          (string-join words gap-string)
          (make-string trailing-spaces #\space)))])))