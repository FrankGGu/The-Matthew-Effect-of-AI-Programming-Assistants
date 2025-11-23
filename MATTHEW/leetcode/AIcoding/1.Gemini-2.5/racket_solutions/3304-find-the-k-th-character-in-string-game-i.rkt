(define (find-kth-character n k)
  (if (= n 1)
      0
      (let* ((len-prev (expt 2 (- n 2)))
             (mid len-prev))
        (if (<= k mid)
            (find-kth-character (- n 1) k)
            (let ((char-prev (find-kth-character (- n 1) (- k mid))))
              (if (= char-prev 0) 1 0))))))