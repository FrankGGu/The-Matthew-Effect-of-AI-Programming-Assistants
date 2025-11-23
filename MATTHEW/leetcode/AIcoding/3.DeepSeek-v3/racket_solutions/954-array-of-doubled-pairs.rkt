(define/contract (can-reorder-doubled arr)
  (-> (listof exact-integer?) boolean?)
  (let* ([pos (filter positive? arr)]
         [neg (filter negative? arr)]
         [zero (filter zero? arr)]
         [pos-sorted (sort pos <)]
         [neg-sorted (sort neg >)]
         [count (make-hash)])
    (for ([num arr])
      (hash-update! count num add1 0))
    (and (even? (length zero))
         (let loop ([lst pos-sorted])
           (if (null? lst)
               #t
               (let ([num (car lst)])
                 (if (= (hash-ref count num 0) 0)
                     (loop (cdr lst))
                     (let ([double (* 2 num)])
                       (if (and (hash-has-key? count double)
                           (let ([cnt (hash-ref count num)]
                                 [double-cnt (hash-ref count double)])
                             (if (>= double-cnt cnt)
                                 (begin
                                   (hash-set! count double (- double-cnt cnt))
                                   (hash-remove! count num)
                                   (loop (cdr lst)))
                                 #f))
                           #f))))))
         (let loop ([lst neg-sorted])
           (if (null? lst)
               #t
               (let ([num (car lst)])
                 (if (= (hash-ref count num 0) 0)
                     (loop (cdr lst))
                     (let ([double (* 2 num)])
                       (if (and (hash-has-key? count double)
                                (>= (hash-ref count double) (hash-ref count num)))
                           (begin
                             (hash-set! count double (- (hash-ref count double) (hash-ref count num)))
                             (hash-remove! count num)
                             (loop (cdr lst)))
                           #f))))))))