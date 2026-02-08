(define (is-possible-divide nums k)
  (let ((n (length nums)))
    (if (not (= (modulo n k) 0))
        #f
        (let* ((counts (make-hash))
               (sorted-nums (sort nums <))
               (count-nums
                (for/list ((num (in-list sorted-nums)))
                  (let ((count (hash-ref counts num 0)))
                    (hash-set! counts num (+ count 1))
                    num))))
          (let loop ((nums sorted-nums))
            (cond
              ((null? nums) #t)
              (else
               (let ((first (car nums)))
                 (if (zero? (hash-ref counts first 0))
                     (loop (cdr nums))
                     (let loop2 ((i 0))
                       (cond
                         ((= i k) (loop (cdr nums)))
                         (else
                          (let ((next-val (+ first i)))
                            (if (zero? (hash-ref counts next-val 0))
                                #f
                                (begin
                                  (hash-update! counts next-val (lambda (x) (- x 1)) 0)
                                  (loop2 (+ i 1))))))))))))))))))