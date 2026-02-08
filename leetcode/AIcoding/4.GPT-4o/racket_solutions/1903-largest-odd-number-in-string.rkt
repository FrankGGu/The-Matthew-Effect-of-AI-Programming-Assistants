(define (largest-odd-number s)
  (define (odd? n) (odd? (string->number n)))
  (define (find-largest-odd lst)
    (foldl (lambda (x acc)
              (if (and (odd? x) (or (null? acc) (> (string->number x) (string->number acc))))
                  x
                  acc))
            #f
            lst))
  (find-largest-odd (string-split s "")))

(largest-odd-number "123456789"))