(define (equalize-frequency s)
  (define (frequencies str)
    (let ((freq (make-hash)))
      (for ([c (in-string str)])
        (hash-update! freq c (λ (v) (+ v 1)) 1))
      (hash->list freq)))

  (define (remove-char str idx)
    (string-append (substring str 0 idx) (substring str (+ idx 1) (string-length str))))

  (define (check-equal str)
    (if (zero? (string-length str))
        #t
        (let ((freq-list (frequencies str)))
          (if (empty? freq-list)
              #t
              (let ((first-freq (cdr (car freq-list))))
                (for/and ([f freq-list])
                  (= (cdr f) first-freq)))))))

  (for/or ([i (in-range (string-length s))])
    (check-equal (remove-char s i))))