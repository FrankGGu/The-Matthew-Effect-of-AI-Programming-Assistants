(define (checkArithmeticSubarrays nums l r)
  (define (is-arithmetic? sublist)
    (define len (length sublist))
    (cond
      [(<= len 2) #t] ; Subarrays with 0, 1, or 2 elements are always arithmetic
      [else
       (define sorted-sublist (sort sublist <))
       (define diff (- (list-ref sorted-sublist 1) (list-ref sorted-sublist 0)))
       (let loop ([i 2])
         (cond
           [(= i len) #t] ; All elements checked, all differences match
           [(= (- (list-ref sorted-sublist i) (list-ref sorted-sublist (- i 1))) diff)
            (loop (+ i 1))]
           [else #f]))]))

  (for/list ([li l] [ri r])
    (define current-subarray-length (+ (- ri li) 1))
    (define current-subarray (take (list-tail nums li) current-subarray-length))
    (is-arithmetic? current-subarray)))