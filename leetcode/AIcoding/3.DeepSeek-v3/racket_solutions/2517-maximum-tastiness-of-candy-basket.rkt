(define/contract (maximum-tastiness price k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([sorted (sort price <)]
         [n (length sorted)]
         [left 0]
         [right (- (last sorted) (first sorted))])
    (define (can-make? target)
      (let loop ([count 1]
                 [last (first sorted)]
                 [i 1])
        (if (>= count k)
            #t
            (if (>= i n)
                #f
                (if (>= (- (list-ref sorted i) last) target)
                    (loop (+ count 1) (list-ref sorted i) (+ i 1))
                    (loop count last (+ i 1))))))
    (let binary-search ([low left]
                       [high right])
      (if (>= low high)
          low
          (let ([mid (quotient (+ low high 1) 2)])
            (if (can-make? mid)
                (binary-search mid high)
                (binary-search low (- mid 1)))))))