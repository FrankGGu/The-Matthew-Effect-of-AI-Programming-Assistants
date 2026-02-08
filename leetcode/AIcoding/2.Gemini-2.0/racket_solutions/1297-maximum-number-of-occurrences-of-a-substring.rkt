(define (max-freq s maxLetters minSize maxSize)
  (let* ([n (string-length s)]
         [freq (make-hash)]
         [max-count 0])
    (for ([i (in-range 0 (- n minSize 0))])
      (for ([len (in-range minSize (+ 1 minSize))])
        (when (<= (+ i len) n)
          (let* ([sub (substring s i (+ i len))]
                 [chars (string->list sub)]
                 [distinct-chars (remove-duplicates chars)])
            (when (<= (length distinct-chars) maxLetters)
              (hash-update! freq sub (λ (v) (+ v 1)) 1))))))
    (for ([(k v) (in-hash freq)])
      (set! max-count (max max-count v)))
    max-count))