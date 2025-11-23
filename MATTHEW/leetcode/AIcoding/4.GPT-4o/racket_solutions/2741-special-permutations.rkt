(define (special-permutations nums)
  (define (is-special? perm)
    (define (gcd a b)
      (if (= b 0) a (gcd b (modulo a b))))
    (for/or ([i (in-range (sub1 (length perm)))])
      (and (not (= (gcd (list-ref perm i) (list-ref perm (add1 i))) 1))
           (not (= (gcd (list-ref perm (add1 i)) (list-ref perm i)) 1)))))

  (define (permute lst)
    (if (null? lst)
        (list '())
        (apply append
               (map (lambda (x)
                      (map (lambda (p) (cons x p))
                           (permute (remove x lst))))
                    lst))))

  (define all-perms (permute nums))
  (length (filter is-special? all-perms)))

(special-permutations '(1 2 3))