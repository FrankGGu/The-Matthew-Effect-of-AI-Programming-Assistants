(define (almost-equivalent? word1 word2)
  (define (char-counts str)
    (define counts (make-hash))
    (for ([c (string->list str)])
      (hash-update! counts c (lambda (v) (+ v 1)) 0))
    counts)

  (define counts1 (char-counts word1))
  (define counts2 (char-counts word2))

  (define all-chars (append (hash-keys counts1) (hash-keys counts2)))

  (for ([c (remove-duplicates all-chars)])
    (let ([count1 (hash-ref counts1 c 0)]
          [count2 (hash-ref counts2 c 0)])
      (when (> (abs (- count1 count2)) 3)
        (return #f))))

  #t)