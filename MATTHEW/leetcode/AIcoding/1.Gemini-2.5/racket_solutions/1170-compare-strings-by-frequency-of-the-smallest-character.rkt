(define (f s)
  (if (string-empty? s)
      0
      (let* ((chars (string->list s))
             (smallest-char (car (sort chars char<?))))
        (count (lambda (c) (char=? c smallest-char)) chars))))

(define (numSmallerByFrequency queries words)
  (let* ((word-freqs (map f words))
         (result (map (lambda (q)
                        (let ((q-freq (f q)))
                          (count (lambda (w-freq) (> w-freq q-freq)) word-freqs)))
                      queries)))
    result))