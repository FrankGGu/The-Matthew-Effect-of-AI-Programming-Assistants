(define (four-sum nums target)
  (define (two-sum nums target)
    (define seen (make-hash))
    (define results '())
    (for ([num nums])
      (define complement (- target num))
      (when (hash-has? seen complement)
        (set! results (cons (list complement num) results)))
      (hash-set! seen num #t))
    results)

  (define (k-sum nums target k)
    (cond
      [(= k 2) (two-sum nums target)]
      [else
       (define results '())
       (define nums (sort nums <))
       (for ([i (in-range (length nums))])
         (when (or (= i 0) (not (= (list-ref nums i) (list-ref nums (- i 1)))))
           (define new-target (- target (list-ref nums i)))
           (define sub-results (k-sum (sublist nums (+ i 1) (length nums)) new-target (- k 1)))
           (for ([res sub-results])
             (set! results (cons (cons (list-ref nums i) res) results)))))
       results)]))

  (define final-results (k-sum nums target 4))
  (define unique-results (remove-duplicates (map (lambda (x) (sort x <)) final-results)))
  (map (lambda (x) (apply list x)) unique-results))

(four-sum '(1 0 -1 0 -2 2) 0)