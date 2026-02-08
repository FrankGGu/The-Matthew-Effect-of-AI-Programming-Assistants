(define (splitString s)
  (define (helper s start curr)
    (if (null? s)
        (if (null? curr) #t #f)
        (for/or ([i (in-range 1 (add1 (length s)))])
          (let* ((next (substring s 0 i))
                 (next-num (string->number next)))
            (when (and next-num
                       (or (null? curr) (= (1- next-num) (car curr))))
              (helper (substring s i) (cons next-num curr)))))))
  (helper s 0 '()))

(splitString "1234") ; Example call