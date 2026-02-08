(define (maximum-strong-pair-xor-ii nums)
  (define (int->bits n)
    (for/list ([i (in-range 31 -1 -1)])
      (if (bitwise-bit-set? n i) 1 0)))

  (define (bits->int bits)
    (foldl (lambda (bit acc) (+ (* acc 2) bit)) 0 bits))

  (define (add-num trie num)
    (define bits (int->bits num))
    (trie-insert! trie bits))

  (define (remove-num trie num)
    (define bits (int->bits num))
    (trie-delete! trie bits))

  (define (max-xor trie num limit)
    (define bits (int->bits num))
    (define (find-max-xor-helper trie bits index)
      (cond
        [(null? bits) 0]
        [else
         (let* ([bit (car bits)]
                [complement (if (= bit 0) 1 0)]
                [next-trie (trie-ref trie complement)])
           (if (and next-trie (<= (abs (- num (bits->int (append (take (int->bits num) (- 31 index)) (list complement) (make-list (- 30 index) 0)))) limit))
               (+ (expt 2 index) (find-max-xor-helper next-trie (cdr bits) (- index 1)))
               (let ([next-trie (trie-ref trie bit)])
                 (if (and next-trie (<= (abs (- num (bits->int (append (take (int->bits num) (- 31 index)) (list bit) (make-list (- 30 index) 0)))) limit)))
                     (find-max-xor-helper next-trie (cdr bits) (- index 1))
                     0)))))]))
    (find-max-xor-helper trie bits 30))

  (let ([sorted-nums (sort nums <)]
        [trie (make-trie)])
    (define (solve sorted-nums trie current-max)
      (if (null? sorted-nums)
          current-max
          (let* ([num (car sorted-nums)]
                 [new-max (max current-max (max-xor trie num num))]
                 [new-trie (add-num trie num)])
            (solve (cdr sorted-nums) trie new-max))))
    (solve sorted-nums trie 0)))