(define (find-target-sum-ways nums target)
  (define n (length nums))
  (define memo (make-hash))

  (define (dfs index current-sum)
    (let* ((key (cons index current-sum)))
      (if (hash-has-key? memo key)
          (hash-ref memo key)
          (if (= index n)
              (if (= current-sum target)
                  1
                  0)
              (let ((result (+ (dfs (+ index 1) (+ current-sum (list-ref nums index)))
                                 (dfs (+ index 1) (- current-sum (list-ref nums index))))))
                (hash-set! memo key result)
                result)))))

  (dfs 0 0))