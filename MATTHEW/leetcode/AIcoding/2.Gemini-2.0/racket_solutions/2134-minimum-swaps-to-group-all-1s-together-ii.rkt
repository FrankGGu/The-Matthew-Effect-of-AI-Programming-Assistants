(define (min-swaps nums)
  (define n (length nums))
  (define ones (count (lambda (x) (= x 1)) nums))
  (if (or (= ones 0) (= ones n))
      0
      (let loop ((i 0) (j (- ones 1)) (window-ones 0) (min-swaps n))
        (cond
          ((= j n) min-swaps)
          (else
           (let ((new-window-ones (+ window-ones (if (= (list-ref nums j) 1) 1 0))))
             (let loop2 ((k i))
               (cond
                 ((>= k n) min-swaps)
                 (else
                  (let ((current-swaps (- ones new-window-ones)))
                    (loop (+ i 1) (+ j 1) (- new-window-ones (if (= (list-ref nums k) 1) 1 0)) (min min-swaps current-swaps))))))))))))