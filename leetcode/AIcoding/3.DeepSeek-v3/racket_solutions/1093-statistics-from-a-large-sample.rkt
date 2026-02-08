(define/contract (sample-stats count)
  (-> (listof exact-integer?) (listof flonum?))
  (let* ([n (apply + count)]
         [min-val (for/first ([i (in-range 256)] #:when (> (list-ref count i) 0)) i)]
         [max-val (for/first ([i (in-range 255 -1 -1)] #:when (> (list-ref count i) 0)) i)]
         [sum (for/sum ([(v cnt) (in-indexed count)] #:when (> cnt 0)) (* v cnt))]
         [mean (/ sum n)]
         [mode (for/fold ([max-count 0] [mode-val 0]) 
                        ([(v cnt) (in-indexed count)] 
                (if (> cnt max-count) (values cnt v) (values max-count mode-val)))]
         [median (let ([mid1 (quotient (sub1 n) 2)]
                       [mid2 (quotient n 2)]
                       [total 0])
                   (for/fold ([med 0.0]) ([(v cnt) (in-indexed count)] #:break (>= total mid2))
                     (let ([new-total (+ total cnt)])
                       (cond 
                         [(and (< total mid1) (>= new-total mid1) (< total mid2) (>= new-total mid2)) 
                          (set! total new-total) v]
                         [(and (< total mid1) (>= new-total mid1)) 
                          (set! total new-total) (+ v (if (< total mid2) (for/first ([(v2 cnt2) (in-indexed count)] 
                                                                           #:when (and (> cnt2 0) (> (+ total cnt2) mid2))) v2) 0)) 0.5)]
                         [(and (< total mid2) (>= new-total mid2)) 
                          (set! total new-total) v]
                         [else (set! total new-total) med]))))])
    (list (exact->inexact min-val) 
          (exact->inexact max-val) 
          mean 
          (if (integer? median) (exact->inexact median) median) 
          (exact->inexact mode))))