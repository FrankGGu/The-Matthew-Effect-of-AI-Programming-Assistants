(define (minimizeResult expression)
  (define parts (string-split expression #\+))
  (define left (string->number (car parts)))
  (define right (string->number (cadr parts)))

  (define (eval-exp a b)
    (+ a b))

  (define min-value +inf.0)
  (define best ""

    (for ([i (in-range (string-length (car parts)))])
      (for ([j (in-range (string-length (cadr parts)))])
        (define new-left (substring (car parts) 0 i))
        (define new-right (substring (cadr parts) j))
        (define new-left-val (if (string=? new-left "") 1 (string->number new-left)))
        (define new-right-val (if (string=? new-right "") 1 (string->number new-right)))
        (define left-part (substring (car parts) i))
        (define right-part (substring (cadr parts) 0 j))
        (define result (eval-exp (+ new-left-val (string->number left-part)) (string->number right-part)))
        (when (< result min-value)
          (set! min-value result)
          (set! best (string-append new-left "+" left-part new-right "+" right-part)))))

    best))

(minimizeResult "12+34")