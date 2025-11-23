(define (reversePairs nums)
  (define (merge-sort arr)
    (if (<= (length arr) 1)
        arr
        (let* ((mid (quotient (length arr) 2))
               (left (merge-sort (sublist arr 0 mid)))
               (right (merge-sort (sublist arr mid)))
               (merged (merge left right)))
          (count-and-merge left right merged))))

  (define (merge left right)
    (cond
      ((null? left) right)
      ((null? right) left)
      (else
       (if (< (car left) (car right))
           (cons (car left) (merge (cdr left) right))
           (cons (car right) (merge left (cdr right)))))))

  (define (count-and-merge left right merged)
    (define (count-reverse-pairs l r)
      (if (null? l)
          0
          (if (and (not (null? r)) (> (car l) (* 2 (car r))))
              (begin
                (count-reverse-pairs l (cdr r))
                (count-reverse-pairs (cdr l) r))
              (count-reverse-pairs (cdr l) r))))
    (define count (count-reverse-pairs left right))
    (values count merged))

  (define (count-pairs arr)
    (define len (length arr))
    (define (count-loop i)
      (if (>= i len)
          0
          (+ (count-loop (+ i 1)) (count-and-merge (sublist arr 0 i) (sublist arr i len)))))
    (count-loop 0))

  (let-values (((count _) (merge-sort nums)))
    count))

(reversePairs '(1 3 2 3 1))