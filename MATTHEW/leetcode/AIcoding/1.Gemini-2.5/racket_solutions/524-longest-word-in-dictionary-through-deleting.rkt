(define (findLongestWord s d)
  (define (is-subsequence? s word)
    (let loop ((s-idx 0)
               (word-idx 0))
      (cond
        ((= word-idx (string-length word)) #t)
        ((= s-idx (string-length s)) #f)
        ((char=? (string-ref s s-idx) (string-ref word word-idx))
         (loop (+ s-idx 1) (+ word-idx 1)))
        (else
         (loop (+ s-idx 1) word-idx)))))

  (foldl (lambda (current-word best-word-so-far)
           (if (is-subsequence? s current-word)
               (let ((current-len (string-length current-word))
                     (best-len (string-length best-word-so-far)))
                 (cond
                   ((> current-len best-len) current-word)
                   ((= current-len best-len)
                    (if (string<? current-word best-word-so-far)
                        current-word
                        best-word-so-far))
                   (else best-word-so-far)))
               best-word-so-far))
         ""
         d))