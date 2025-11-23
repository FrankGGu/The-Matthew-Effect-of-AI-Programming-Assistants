(define (find-min-fibonacci-numbers k)
  (if (= k 0)
      0
      (let loop-fib ((a 1) (b 1) (fibs '()))
        (if (> a k)
            (let loop-sum ((current-k k) (count 0) (fib-list fibs))
              (if (= current-k 0)
                  count
                  (let find-largest-fib ((remaining-fibs fib-list))
                    (let ((f (car remaining-fibs)))
                      (if (<= f current-k)
                          (loop-sum (- current-k f) (+ count 1) remaining-fibs)
                          (find-largest-fib (cdr remaining-fibs)))))))
            (loop-fib b (+ a b) (cons a fibs))))))