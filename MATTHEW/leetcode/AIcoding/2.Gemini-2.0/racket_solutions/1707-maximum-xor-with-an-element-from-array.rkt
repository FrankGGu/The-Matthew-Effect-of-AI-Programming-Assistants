(define (maximum-xor-with-element-from-array nums queries)
  (define (int->bits n)
    (reverse
     (let loop ([n n] [bits '()])
       (if (zero? n)
           bits
           (loop (quotient n 2) (cons (remainder n 2) bits))))))

  (define (pad-bits bits)
    (let ([len (length bits)])
      (if (< len 31)
          (append (make-list (- 31 len) 0) bits)
          bits)))

  (define trie (make-trie))
  (for-each (lambda (num)
              (trie-add! trie (pad-bits (int->bits num)) #t))
            nums)

  (define (find-max-xor num)
    (let ([bits (pad-bits (int->bits num))])
      (let loop ([bits bits] [node trie] [xor 0])
        (cond
          [(null? bits) xor]
          [(trie-has-prefix? node (cons (if (= (car bits) 0) 1 0) '()))
           (loop (cdr bits) (trie-ref node (cons (if (= (car bits) 0) 1 0) '())) (+ xor (expt 2 (- 30 (count-value bits)))))]
          [else
           (loop (cdr bits) (trie-ref node (cons (car bits) '())) xor)]))))

  (map (lambda (query)
         (let ([num (car query)] [limit (cadr query)])
           (let ([filtered-nums (filter (lambda (x) (<= x limit)) nums)])
             (if (null? filtered-nums)
                 -1
                 (apply max (map (lambda (x) (bitwise-xor num x)) filtered-nums))))))
       queries))