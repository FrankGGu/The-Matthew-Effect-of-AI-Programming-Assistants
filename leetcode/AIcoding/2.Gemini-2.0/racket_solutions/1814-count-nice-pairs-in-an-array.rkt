(define (rev x)
  (string->number (list->string (reverse (string->list (number->string x))))))

(define (count-nice-pairs nums)
  (let* ([diffs (map (lambda (x) (- x (rev x))) nums)]
         [counts (make-hash)])
    (for-each (lambda (x)
                (hash-update! counts x (lambda (k v) (+ v 1)) 1))
              diffs)
    (let loop ([vs (hash-values counts)] [acc 0])
      (if (null? vs)
          (modulo acc 1000000007)
          (let ([n (car vs)])
            (loop (cdr vs) (+ acc (/ (* n (- n 1)) 2))))))))