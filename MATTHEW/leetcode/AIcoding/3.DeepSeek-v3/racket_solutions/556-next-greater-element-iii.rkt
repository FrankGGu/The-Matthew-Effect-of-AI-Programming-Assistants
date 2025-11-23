(define (next-greater-element n)
  (let* ((s (string->list (number->string n)))
    (let loop ((i (- (length s) 2)))
      (cond
        [(< i 0) -1]
        [(char>? (list-ref s i) (list-ref s (+ i 1))) (loop (- i 1))]
        [else
         (let loop2 ((j (- (length s) 1)))
           (if (char<=? (list-ref s j) (list-ref s i))
               (loop2 (- j 1))
               (let* ((s-swapped (list-copy s))
                     (tmp (list-ref s-swapped i))
                     (_ (list-set! s-swapped i (list-ref s-swapped j)))
                     (_ (list-set! s-swapped j tmp))
                     (s-reversed (reverse (list-tail s-swapped (+ i 1))))
                 (let ((result (string->number (list->string (append (take s-swapped (+ i 1)) s-reversed)))))
                   (if (or (not result) (> result 2147483647))
                       -1
                       result)))))]))))