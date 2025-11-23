(define (punishment-number n)
  (letrec ((is-punishment? (lambda (num)
                            (let loop ((s (number->string num))
                                       (idx 0)
                                       (total 0))
                              (cond
                                ((= idx (string-length s)) (= total num))
                                (else
                                 (let ((sum 0))
                                   (for ((i (in-range idx (string-length s))))
                                     (set! sum (+ sum (* (- (char->integer (string-ref s i)) (char->integer #\0)) (expt 10 (- (string-length s) i -1)))))
                                     (when (is-punishment? (string->number (substring s 0 idx)) (substring s idx i) (+ total sum))
                                       (return #t))))
                                 #f)))))
            (is-punishment? (lambda (num s total)
                            (cond
                              ((null? s) (= total num))
                              (else
                               (let ((val (string->number s)))
                                 (= (+ total val) num))))))
    (let loop ((i 1)
               (sum 0))
      (cond
        ((> i n) sum)
        (else
         (if (is-punishment? (* i i))
             (loop (+ i 1) (+ sum (* i i)))
             (loop (+ i 1) sum)))))))