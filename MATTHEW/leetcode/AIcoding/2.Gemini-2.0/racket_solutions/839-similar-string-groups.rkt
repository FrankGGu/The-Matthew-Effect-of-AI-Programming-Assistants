(define (num-different s1 s2)
  (let loop ([s1 (string->list s1)] [s2 (string->list s2)] [count 0])
    (cond
      [(empty? s1) count]
      [(equal? (car s1) (car s2)) (loop (cdr s1) (cdr s2) count)]
      [else (loop (cdr s1) (cdr s2) (+ count 1))])))

(define (are-similar? s1 s2)
  (<= (num-different s1 s2) 2))

(define (find-root parent i)
  (if (= i (list-ref parent i))
      i
      (let ([root (find-root parent (list-ref parent i))])
        (list-set! parent i root)
        root)))

(define (union-sets parent rank i j)
  (let ([root-i (find-root parent i)] [root-j (find-root parent j)])
    (unless (= root-i root-j)
      (if (< (list-ref rank root-i) (list-ref rank root-j))
          (begin
            (list-set! parent root-i root-j))
          (begin
            (list-set! parent root-j root-i)
            (if (= (list-ref rank root-i) (list-ref rank root-j))
                (list-set! rank root-i (+ (list-ref rank root-i) 1))))))))

(define (num-similar-groups strs)
  (let ([n (length strs)])
    (let ([parent (list->vector (range n))]
          [rank (list->vector (make-list n 0))])
      (for* ([i (range n)] [j (range i n)])
        (when (are-similar? (list-ref strs i) (list-ref strs j))
          (union-sets (vector->list parent) (vector->list rank) i j)
          (set! parent (list->vector (vector->immutable-vector parent)))
          (set! rank (list->vector (vector->immutable-vector rank)))))
      (let ([roots (make-hash)])
        (for ([i (range n)])
          (let ([root (find-root (vector->list parent) i)])
            (hash-set! roots root #t)))
        (hash-count roots)))))