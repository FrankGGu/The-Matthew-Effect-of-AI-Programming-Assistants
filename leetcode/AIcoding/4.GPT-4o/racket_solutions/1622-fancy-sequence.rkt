(define (Fancy)
  (define mod 1000000007)
  (define sequences '())
  (define operations '())

  (define (add x)
    (set! sequences (append sequences (list x)))
    (set! operations (append operations (list 'add)))
    (modulo-sum))

  (define (multiply x)
    (set! operations (append operations (list 'multiply x)))
    (modulo-sum))

  (define (modulo-sum)
    (define sum 0)
    (for-each (lambda (num) (set! sum (modulo (+ sum num) mod))) sequences)
    sum)

  (define (get-index i)
    (if (and (>= i 0) (< i (length sequences)))
        (list-ref sequences i)
        -1))

  (define (get-operations)
    (map (lambda (op)
           (if (eq? (car op) 'multiply)
               (list 'multiply (cadr op))
               'add))
         operations))

  (define (get-sequence)
    sequences)

  (define (get-mod)
    mod)

  (lambda (op . args)
    (case op
      ((add) (add (car args)))
      ((multiply) (multiply (car args)))
      ((get-index) (get-index (car args)))
      ((get-operations) (get-operations))
      ((get-sequence) (get-sequence))
      ((get-mod) (get-mod)))))