(define (sumOfStrengths strength)
  (define n (length strength))
  (define mod 1000000007)

  (define left (make-vector n))
  (define right (make-vector n))

  (define stack '())

  (for ((i (in-range n)))
    (begin
      (while (and (not (null? stack)) (< (vector-ref strength (car (car stack))) (vector-ref strength i)))
        (set! stack (cdr stack)))
      (vector-set! left i (if (null? stack) -1 (car (car stack))))
      (set! stack (cons (cons i (vector-ref strength i)) stack))))

  (set! stack '())

  (for ((i (in-range (- n 1) -1 -1)))
    (begin
      (while (and (not (null? stack)) (< (vector-ref strength (car (car stack))) (vector-ref strength i)))
        (set! stack (cdr stack)))
      (vector-set! right i (if (null? stack) n (car (car stack))))
      (set! stack (cons (cons i (vector-ref strength i)) stack))))

  (define total-strength (make-vector n))

  (for ((i (in-range n)))
    (let* ((l (vector-ref left i))
           (r (vector-ref right i))
           (strength-contrib (if (= l -1) 
                                 (if (= r n) 
                                     (vector-ref strength i) 
                                     (modulo (* (vector-ref strength i) (+ 1 (- r i))) mod))
                                 (if (= r n) 
                                     (modulo (* (vector-ref strength i) (+ 1 (- i l))) mod)
                                     (modulo (* (vector-ref strength i) 
                                                 (modulo (+ 1 (- r i) (+ 1 (- i l))) mod)) mod)))))
      (vector-set! total-strength i strength-contrib)))

  (define total 0)

  (for ((i (in-range n)))
    (set! total (modulo (+ total (vector-ref total-strength i)) mod)))

  total)

(define (sumOfTotalStrength strength)
  (sumOfStrengths strength))