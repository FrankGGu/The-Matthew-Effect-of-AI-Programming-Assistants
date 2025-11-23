(define (count-k-divisible-elements-subarrays nums k p)
  (define (count-divisible-elements arr)
    (length (filter (lambda (x) (<= x p)) (map (lambda (x) (if (zero? (modulo x k)) 1 0)) arr))))

  (define (subarrays arr)
    (let loop ([i 0] [result '()])
      (if (= i (length arr))
          result
          (let loop2 ([j i] [sub-arr '()])
            (if (= j (length arr))
                (loop (+ i 1) result)
                (let ([new-sub-arr (append sub-arr (list (list-ref arr j)))])
                  (loop2 (+ j 1) new-sub-arr (cons new-sub-arr result))))))))

  (define (to-string lst)
    (string-join (map (lambda (x) (number->string x)) lst) ","))

  (define (distinct-subarrays arr)
    (let ([sub-arrs (subarrays arr)])
      (let ([seen (make-hash)])
        (let loop ([lst sub-arrs] [count 0])
          (cond
            [(null? lst) count]
            [else
             (let ([sub-arr (car lst)]
                   [key (to-string sub-arr)])
               (if (hash-has-key? seen key)
                   (loop (cdr lst) count)
                   (begin
                     (hash-set! seen key #t)
                     (loop (cdr lst) (+ count 1)))))])))))

  (distinct-subarrays (filter (lambda (x) (<= (count-divisible-elements x) p)) (subarrays nums))))