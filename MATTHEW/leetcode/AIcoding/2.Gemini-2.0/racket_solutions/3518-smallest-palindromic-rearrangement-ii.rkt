(define (smallest-palindromic-rearrangement s)
  (define counts (make-hash))
  (for ([c (in-string s)])
    (hash-update! counts c (λ (v) (+ v 1)) 1))

  (define odd-chars '())
  (for ([(c count) (in-hash counts)])
    (when (odd? count)
      (set! odd-chars (cons c odd-chars))))

  (when (> (length odd-chars) 1)
    (return #f))

  (define half-str "")
  (for ([(c count) (in-hash counts)])
    (set! half-str (string-append half-str (make-string (/ count 2) c))))

  (define sorted-half-str (list->string (sort (string->list half-str) char<?)))

  (define middle-char (if (null? odd-chars) "" (string (car odd-chars))))

  (string-append sorted-half-str middle-char (list->string (reverse (string->list sorted-half-str)))))

(provide smallest-palindromic-rearrangement)