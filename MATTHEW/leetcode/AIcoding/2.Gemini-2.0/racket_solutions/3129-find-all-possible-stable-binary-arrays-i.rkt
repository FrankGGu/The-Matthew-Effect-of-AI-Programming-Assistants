(define (stable-arrays n k)
  (letrec ((helper
            (lambda (idx current-arr count)
              (cond
                ((= idx n)
                 (if (= count k)
                     (list current-arr)
                     '()))
                (else
                 (append (helper (+ idx 1) (append current-arr (list 0)) count)
                         (helper (+ idx 1) (append current-arr (list 1)) (+ count (if (or (null? current-arr) (zero? (last current-arr))) 1 0)))))))))
    (helper 0 '() 0)))