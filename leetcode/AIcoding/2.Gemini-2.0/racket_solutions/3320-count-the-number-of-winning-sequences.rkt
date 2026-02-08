(define (count-winning-sequences nums k)
  (define n (length nums))
  (define (factorial x)
    (if (= x 0)
        1
        (* x (factorial (- x 1)))))
  (define (ncr n r)
    (/ (factorial n) (* (factorial r) (factorial (- n r)))))

  (define counts (make-hash))
  (for-each (lambda (x) (hash-update! counts x (λ (v) (+ v 1)) 1)) nums)

  (define (dfs remaining_slots used_nums)
    (if (= remaining_slots 0)
        1
        (let loop ((num_list (hash-keys counts))
                   (total 0))
          (cond
            [(empty? num_list) total]
            [else
             (let* ((num (car num_list))
                    (count (hash-ref counts num 0)))
               (if (> count (hash-ref used_nums num 0))
                   (let* ((new_used_nums (hash-copy used_nums))
                          (new_total (+ total (* (expt (- k 1) (hash-ref used_nums num 0))
                                                  (dfs (- remaining_slots 1)
                                                       (hash-update! new_used_nums num (λ (v) (+ v 1)) 1))))))
                     (loop (cdr num_list) new_total))
                   (loop (cdr num_list) total)))])))))

  (dfs n (make-hash)))