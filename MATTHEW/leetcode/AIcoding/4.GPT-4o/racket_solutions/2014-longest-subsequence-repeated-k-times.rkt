(define (longest-subsequence-repeated-k-times arr k)
  (define freq (make-hash))
  (for ([num arr])
    (hash-set! freq num (+ 1 (hash-ref freq num 0))))
  (define candidates (filter (lambda (x) (= (hash-ref freq x) k)) (hash-keys freq)))
  (if (null? candidates)
      '()
      (let loop ((candidates candidates) (longest '()))
        (if (null? candidates)
            longest
            (let* ((current (car candidates))
                   (current-len (length (filter (lambda (x) (= x current)) arr))))
              (loop (cdr candidates) (if (> current-len (length longest)) (list current) longest))))))))

(define (longest-subsequence-repeated-k-times-wrapper arr k)
  (longest-subsequence-repeated-k-times arr k))

(longest-subsequence-repeated-k-times-wrapper '(1 2 3 1 2 1 3 1) 2)