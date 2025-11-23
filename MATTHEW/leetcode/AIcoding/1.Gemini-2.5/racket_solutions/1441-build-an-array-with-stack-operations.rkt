(define (build-array target n)
  (let loop ((current-num 1)
             (target-idx 0)
             (ops '()))
    (cond
      ((or (> current-num n)
           (= target-idx (length target)))
       (reverse ops))
      (else
       (let ((target-val (list-ref target target-idx)))
         (if (= current-num target-val)
             (loop (+ current-num 1)
                   (+ target-idx 1)
                   (cons "Push" ops))
             (loop (+ current-num 1)
                   target-idx
                   (cons "Pop" (cons "Push" ops)))))))))