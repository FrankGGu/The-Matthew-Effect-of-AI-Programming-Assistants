(define (countAndSay n)
  (if (= n 1)
      "1"
      (let* ((prev-seq (countAndSay (- n 1))))
        (let count-and-say-helper ((s prev-seq)
                                   (idx 0)
                                   (len (string-length prev-seq))
                                   (acc '()))
          (if (>= idx len)
              (string-append* (reverse acc))
              (let* ((current-char (string-ref s idx)))
                (let find-next-diff ((j (+ idx 1))
                                     (count 1))
                  (if (and (< j len) (char=? (string-ref s j) current-char))
                      (find-next-diff (+ j 1) (+ count 1))
                      (count-and-say-helper s
                                            j
                                            len
                                            (cons (string current-char) (cons (number->string count) acc)))))))))))