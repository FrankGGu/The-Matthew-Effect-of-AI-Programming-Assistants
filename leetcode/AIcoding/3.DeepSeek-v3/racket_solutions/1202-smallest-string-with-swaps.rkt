#lang racket

(define (smallest-string-with-swaps s pairs)
  (define n (string-length s))
  (define parent (make-vector n -1))

  (define (find u)
    (if (negative? (vector-ref parent u))
        u
        (let ([root (find (vector-ref parent u))])
          (vector-set! parent u root)
          root)))

  (define (union u v)
    (let ([root-u (find u)]
          [root-v (find v)])
      (unless (equal? root-u root-v)
        (if (< root-u root-v)
            (begin
              (vector-set! parent root-v root-u)
              (vector-set! parent root-u (- (+ (vector-ref parent root-u) (vector-ref parent root-v)))))
            (begin
              (vector-set! parent root-u root-v)
              (vector-set! parent root-v (- (+ (vector-ref parent root-u) (vector-ref parent root-v)))))))))

  (for ([pair pairs])
    (union (car pair) (cadr pair)))

  (define groups (make-hash))
  (for ([i (in-range n)])
    (let ([root (find i)])
      (hash-update! groups root (lambda (lst) (cons i lst)) (list i))))

  (define result (make-string n #\a))
  (for ([(root indices) groups])
    (let* ([sorted-chars (sort (map (lambda (i) (string-ref s i)) indices) char<?)]
           [sorted-indices (sort indices <)])
      (for ([i (in-list sorted-indices)]
             [ch (in-list sorted-chars)])
        (string-set! result i ch))))
  result)