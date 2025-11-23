(define (count-special-integers n)
  (define (count-unique-digits len is_prefix prefix)
    (if (= len 0)
        1
        (let* ((start (if is_prefix 1 0))
               (count (if is_prefix 0 1)))
          (for/sum ((d (in-range start 10)))
            (count-unique-digits (- len 1) #f (cons d prefix))))))

  (define (count-upto-digits num)
    (let loop ((digits (number->list num))
               (len (length digits))
               (total 0)
               (is_prefix #t)
               (prefix '()))
      (if (null? digits)
          total
          (let* ((current (car digits))
                 (remaining (cdr digits))
                 (count (count-unique-digits (- len 1) is_prefix prefix)))
            (loop remaining
                  (- len 1)
                  (+ total count)
                  (if is_prefix 
                      #t 
                      #f)
                  (if (or (not is_prefix) (> current 0))
                      (cons current prefix)
                      prefix)))))

  (+ (count-upto-digits n) (count-unique-digits (length (number->list n)) #t '())))