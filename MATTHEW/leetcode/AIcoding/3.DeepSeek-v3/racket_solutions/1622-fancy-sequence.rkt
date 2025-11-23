(define fancy-sequence%
  (class object%
    (super-new)
    (init-field)
    (define lst '())
    (define add 0)
    (define mult 1)

    (define/public (append val)
      (set! lst (cons (modulo (quotient (- val add) mult) lst)))

    (define/public (add-all inc)
      (set! add (modulo (+ add inc) 1000000007)))

    (define/public (mult-all m)
      (set! add (modulo (* add m) 1000000007))
      (set! mult (modulo (* mult m) 1000000007)))

    (define/public (get-index idx)
      (if (>= idx (length lst))
          -1
          (modulo (+ (* (list-ref lst idx) mult) add) 1000000007)))))

(define (make-fancy-sequence) (new fancy-sequence%))