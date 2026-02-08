(define (findLexSmallest)
  (let loop ((n 1) (result '()))
    (if (= n 0)
        (list->string (reverse result))
        (let ((next (if (null? result) 1 (+ 1 (car result)))))
          (loop (- n 1) (cons next result))))))

(define (findTheSequence n)
  (findLexSmallest))