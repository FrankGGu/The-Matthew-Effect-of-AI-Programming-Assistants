(define (longest-substring-of-all-vowels s)
  (define vowels (list #\a #\e #\i #\o #\u))
  (define s-len (string-length s))

  (let loop ((idx 0)
             (max-len 0)
             (current-len 0)
             (vowel-idx 0)
             (has-all-vowels #f))
    (if (= idx s-len)
        max-len
        (let* ((char (string-ref s idx))
               (expected-vowel (list-ref vowels vowel-idx)))
          (cond
            ((char=? char expected-vowel)
             (let ((new-current-len (+ current-len 1))
                   (new-has-all-vowels (or has-all-vowels (= vowel-idx 4))))
               (loop (+ idx 1)
                     (if new-has-all-vowels (max max-len new-current-len) max-len)
                     new-current-len
                     vowel-idx
                     new-has-all-vowels)))

            ((and (< vowel-idx 4) (char=? char (list-ref vowels (+ vowel-idx 1))))
             (let* ((new-vowel-idx (+ vowel-idx 1))
                    (new-current-len (+ current-len 1))
                    (new-has-all-vowels (or has-all-vowels (= new-vowel-idx 4))))
               (loop (+ idx 1)
                     (if new-has-all-vowels (max max-len new-current-len) max-len)
                     new-current-len
                     new-vowel-idx
                     new-has-all-vowels)))

            (else
             (let ((new-current-len 0)
                   (new-vowel-idx 0)
                   (new-has-all-vowels #f))
               (if (char=? char #\a)
                   (loop (+ idx 1) max-len 1 0 #f)
                   (loop (+ idx 1) max-len 0 0 #f))))))))