(define (count-special-numbers n)
  (let* ((s (number->string n))
         (len (string-length s)))
    (define (count-distinct-digits k)
      (if (= k 0)
          1
          (* (count-distinct-digits (- k 1))
             (- (+ 10 (- k 1))
                (- k 1)))))
    (define (count-less-than-len k used-digits)
      (if (= k 0)
          1
          (let ((available (- 10 (length used-digits))))
            (* available
               (count-less-than-len (- k 1) used-digits)))))
    (define (count-less-than-prefix idx used-digits)
      (if (= idx len)
          1
          (let ((digit (string->number (substring s idx (+ idx 1))))
                (result 0))
            (for ((i (in-range (if (= idx 0) 1 0) digit)))
              (if (not (member i used-digits))
                  (set! result (+ result 1))))
            (if (member digit used-digits)
                result
                (if (= (length used-digits) len)
                    result
                    (+ result
                       (if (= (length used-digits) (- len idx 1))
                           1
                           (count-less-than-prefix (+ idx 1) (append used-digits (list digit))))))))))
    (let ((result 0))
      (for ((i (in-range 1 len)))
        (set! result (+ result (* 9 (count-distinct-digits (- i 1))))))
      (set! result (+ result (count-less-than-prefix 0 '())))
      (- n result))))