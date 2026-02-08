(define (max-number nums1 nums2 k)
  (define (merge a b)
    (let loop ((a a) (b b) (res '()))
      (cond [(null? a) (append (reverse res) b)]
            [(null? b) (append (reverse res) a)]
            [else (let ([a-tail (list-tail a 1)]
                       [b-tail (list-tail b 1)])
                    (if (lex>? a b)
                        (loop a-tail b (cons (car a) res))
                        (loop a b-tail (cons (car b) res)))])))

  (define (lex>? a b)
    (let loop ([a a] [b b])
      (cond [(null? b) #t]
            [(null? a) #f]
            [(> (car a) (car b)) #t]
            [(< (car a) (car b)) #f]
            [else (loop (cdr a) (cdr b))])))

  (define (max-subsequence nums k)
    (let loop ([nums nums] [k k] [res '()])
      (if (zero? k)
          (reverse res)
          (let ([n (length nums)])
            (let ([drop (max 0 (- n k 1))])
              (let ([idx (argmax (lambda (i) (list-ref nums i)) (range 0 (+ drop 1) 1))])
                (loop (list-tail nums (+ idx 1)) (- k 1) (cons (list-ref nums idx) res))))))))

  (let ([max-res #f])
    (for ([i (in-range (max 0 (- k (length nums2))) (min k (length nums1)) 1)])
      (let ([a (max-subsequence nums1 i)]
            [b (max-subsequence nums2 (- k i))])
        (let ([merged (merge a b)])
          (when (or (not max-res) (lex>? merged max-res))
            (set! max-res merged)))))
    (if max-res max-res '())))