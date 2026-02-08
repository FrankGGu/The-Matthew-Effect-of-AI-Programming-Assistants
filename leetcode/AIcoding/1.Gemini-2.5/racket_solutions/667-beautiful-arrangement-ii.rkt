(define (construct-beautiful-arrangement n k)
  (let* ((first-part-len (+ k 1))
         (first-part
          (let loop ((i 0) (l 1) (r (+ k 1)) (acc '()))
            (if (= i first-part-len)
                (reverse acc)
                (if (even? i)
                    (loop (+ i 1) (+ l 1) r (cons l acc))
                    (loop (+ i 1) l (- r 1) (cons r acc)))))))
    (append first-part
            (build-list (- n first-part-len)
                        (lambda (idx) (+ first-part-len 1 idx))))))