(define (num-different-chars s1 s2)
  (let loop ([s1 (string->list s1)]
             [s2 (string->list s2)]
             [count 0])
    (cond [(empty? s1) count]
          [(equal? (car s1) (car s2)) (loop (cdr s1) (cdr s2) count)]
          [else (loop (cdr s1) (cdr s2) (+ count 1))])))

(define (are-similar s1 s2)
  (let ([diff-count (num-different-chars s1 s2)])
    (or (= diff-count 0) (= diff-count 2))))

(define (num-similar-groups strs)
  (let* ([n (length strs)]
         [parent (make-vector n)]
         [rank (make-vector n)]
         (for ([i (in-range n)])
           (vector-set! parent i i)
           (vector-set! rank i 0)))

    (define (find i)
      (if (equal? (vector-ref parent i) i)
          i
          (let ([root (find (vector-ref parent i))])
            (vector-set! parent i root)
            root)))

    (define (union i j)
      (let ([root-i (find i)]
            [root-j (find j)])
        (unless (equal? root-i root-j)
          (if (< (vector-ref rank root-i) (vector-ref rank root-j))
              (vector-set! parent root-i root-j)
              (begin
                (vector-set! parent root-j root-i)
                (when (equal? (vector-ref rank root-i) (vector-ref rank root-j))
                  (vector-set! rank root-i (+ (vector-ref rank root-i) 1))))))))

    (for* ([i (in-range n)]
           [j (in-range (+ i 1) n)])
      (when (are-similar (list-ref strs i) (list-ref strs j))
        (union i j)))

    (let loop ([i 0]
               [count 0])
      (if (= i n)
          count
          (loop (+ i 1) (if (equal? (vector-ref parent i) i) (+ count 1) count))))))