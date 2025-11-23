(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (modulo a b))))

(define (gcd-pairs nums queries)
  (let* ((sorted-nums (sort nums <))
         (gcd-values (map (lambda (x)
                            (foldl gcd 0 (filter (lambda (y) (<= y x)) sorted-nums)))
                          sorted-nums)))
    (map (lambda (query)
           (let ((l (car query))
                 (r (cadr query)))
             (apply gcd (sublist gcd-values l r))))
         queries)))

(define (sublist lst start end)
  (take (drop lst start) (- end start)))

(define (take lst n)
  (if (or (zero? n) (null? lst))
      '()
      (cons (car lst) (take (cdr lst) (- n 1)))))

(define (drop lst n)
  (if (zero? n)
      lst
      (drop (cdr lst) (- n 1))))

(define (sort lst cmp)
  (if (null? lst)
      '()
      (let ((pivot (car lst)))
        (append (sort (filter (lambda (x) (cmp x pivot)) (cdr lst)) cmp)
                (list pivot)
                (sort (filter (lambda (x) (not (cmp x pivot))) (cdr lst)) cmp)))))

(define (sorted-gcd-pair-queries nums queries)
  (gcd-pairs nums queries))