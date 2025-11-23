(define (parseBoolExpr expression)
  (define (parse s idx)
    (let ((char (string-ref s idx)))
      (cond
        ((char=? char #\t)
         (cons #t (+ idx 1)))
        ((char=? char #\f)
         (cons #f (+ idx 1)))
        ((char=? char #\!)
         ;; Skip '!' and '('
         (let-values (((val next-idx) (parse s (+ idx 2))))
           ;; Skip ')'
           (cons (not val) (+ next-idx 1))))
        ((char=? char #\&)
         ;; Skip '&' and '('
         (let loop ((current-idx (+ idx 2))
                    (result #t))
           (let-values (((sub-val sub-next-idx) (parse s current-idx)))
             (let ((new-result (and result sub-val)))
               (if (char=? (string-ref s sub-next-idx) #\))
                   ;; Found ')' - end of expression list
                   (cons new-result (+ sub-next-idx 1))
                   ;; Found ',' - continue parsing
                   (loop (+ sub-next-idx 1) new-result))))))
        ((char=? char #\|)
         ;; Skip '|' and '('
         (let loop ((current-idx (+ idx 2))
                    (result #f))
           (let-values (((sub-val sub-next-idx) (parse s current-idx)))
             (let ((new-result (or result sub-val)))
               (if (char=? (string-ref s sub-next-idx) #\))
                   ;; Found ')' - end of expression list
                   (cons new-result (+ sub-next-idx 1))
                   ;; Found ',' - continue parsing
                   (loop (+ sub-next-idx 1) new-result))))))
        (else
         (error "Invalid character in expression")))))
  (car (parse expression 0)))