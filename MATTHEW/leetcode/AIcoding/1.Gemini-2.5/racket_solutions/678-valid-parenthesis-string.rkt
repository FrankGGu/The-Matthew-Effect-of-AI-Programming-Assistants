(define (check-valid-string s)
  (let* ((len (string-length s)))
    (let loop ((i 0)
               (min-open 0)
               (max-open 0))
      (if (= i len)
          (= min-open 0)
          (let* ((char (string-ref s i)))
            (let ((next-min-open
                   (cond
                     ((char=? char #\() (+ min-open 1))
                     ((char=? char #\)) (max 0 (- min-open 1)))
                     ((char=? char #\*) (max 0 (- min-open 1))))))
              (let ((next-max-open
                     (cond
                       ((char=? char #\() (+ max-open 1))
                       ((char=? char #\)) (- max-open 1))
                       ((char=? char #\*) (+ max-open 1))))))
                (if (< next-max-open 0)
                    #f
                    (loop (+ i 1) next-min-open next-max-open))))))))