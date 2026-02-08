(define (common-chars A)
  (define (intersect-counts counts)
    (foldr (lambda (count acc)
             (map min count acc))
           (car counts)
           (cdr counts)))

  (define (string->char-counts s)
    (let ((counts (make-vector 26 0)))
      (for ((c (in-string s)))
        (vector-set! counts (- (char->integer c) (char->integer #\a)) (+ 1 (vector-ref counts (- (char->integer c) (char->integer #\a))))))
      counts))

  (define counts (map string->char-counts A))
  (define intersection (intersect-counts counts))

  (define result '())
  (for ((i (in-range 26)))
    (for ((j (in-range (vector-ref intersection i))))
      (set! result (cons (integer->char (+ (char->integer #\a) i)) result))))

  (reverse result))