(define (count-good-substrings s)
  (define (distinct? str)
    (= (string-length str) (length (remove-duplicates (string->list str)))))
  (define (helper s count)
    (if (< (string-length s) 3)
        count
        (helper (substring s 1) (if (distinct? (substring s 0 3))
                                     (+ count 1)
                                     count))))
  (helper s 0))

(count-good-substrings "xyzzaz")