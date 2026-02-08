(define/contract (garbage-collection garbage travel)
  (-> (listof string?) (listof integer?) exact-integer?)
  (let* ([n (length garbage)]
         [last-m (let loop ([i 0] [last -1])
                   (if (>= i n)
                       last
                       (if (string-contains? (list-ref garbage i) "M")
                           (loop (add1 i) i)
                           (loop (add1 i) last))))]
         [last-p (let loop ([i 0] [last -1])
                   (if (>= i n)
                       last
                       (if (string-contains? (list-ref garbage i) "P")
                           (loop (add1 i) i)
                           (loop (add1 i) last))))]
         [last-g (let loop ([i 0] [last -1])
                   (if (>= i n)
                       last
                       (if (string-contains? (list-ref garbage i) "G")
                           (loop (add1 i) i)
                           (loop (add1 i) last))))]
         [sum-time (lambda (last)
                     (let loop ([i 0] [time 0])
                       (if (> i last)
                           time
                           (loop (add1 i) (+ time (string-length (list-ref garbage i))))))]
         [sum-travel (lambda (last)
                       (if (<= last 0)
                           0
                           (let loop ([i 0] [sum 0])
                             (if (>= i (sub1 last))
                                 sum
                                 (loop (add1 i) (+ sum (list-ref travel i)))))))])
    (+ (sum-time last-m) (sum-travel last-m)
       (sum-time last-p) (sum-travel last-p)
       (sum-time last-g) (sum-travel last-g))))