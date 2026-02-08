#lang racket

(define (adjacent-increasing-subarrays-detection-i nums)
  (let ([n (length nums)])
    (cond
      [(< n 2) #f] ; Need at least two elements to form two non-empty subarrays
      [else
       (let* ([vec (list->vector nums)]
              ; prefix-inc[k] is #t if vec[0...k-1] is strictly increasing
              ; Size n+1: prefix-inc[0] for empty, prefix-inc[n] for full array
              [prefix-inc (make-vector (+ n 1) #t)]
              ; suffix-inc[k] is #t if vec[k...n-1] is strictly increasing
              ; Size n+1: suffix-inc[n] for empty, suffix-inc[0] for full array
              [suffix-inc (make-vector (+ n 1) #t)])

         ; Calculate prefix-inc array
         ; prefix-inc[0] and prefix-inc[1] are already #t
         (for ([k (in-range 2 (+ n 1))]) ; k from 2 to n
           (vector-set! prefix-inc k
                        (and (vector-ref prefix-inc (- k 1))
                             (< (vector-ref vec (- k 2)) (vector-ref vec (- k 1))))))

         ; Calculate suffix-inc array
         ; suffix-inc[n] and suffix-inc[n-1] are already #t
         (for ([k (in-range (- n 2) -1 -1)]) ; k from n-2 down to 0
           (vector-set! suffix-inc k
                        (and (vector-ref suffix-inc (+ k 1))
                             (< (vector-ref vec k) (vector-ref vec (+ k 1))))))

         ; Check for a split point 'i' (0 < i < n)
         ; where the first subarray is vec[0...i-1] and the second is vec[i...n-1]
         (let loop ([i 1]) ; 'i' is the split index, from 1 to n-1
           (cond
             [(>= i n) #f] ; No more valid split points
             [else
              (if (and (vector-ref prefix-inc i)
                       (vector-ref suffix-inc i))
                  #t ; Found a valid split
                  (loop (+ i 1)))])))))))