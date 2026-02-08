(require racket/hash)

(define (check-subarray-sum nums k)
  (let ([n (vector-length nums)])
    (let loop ([i 0]
               [current-sum 0]
               [remainder-map (hash 0 -1)]) ; Map remainder to first seen index
      (cond
        [(= i n) #f] ; Base case: iterated through all elements, no subarray found
        [else
         (let* ([new-current-sum (+ current-sum (vector-ref nums i))]
                [remainder (if (= k 0)
                               new-current-sum
                               (modulo new-current-sum k))])
           (cond
             [(hash-has-key? remainder-map remainder)
              (let ([prev-index (hash-ref remainder-map remainder)])
                (if (>= (- i prev-index) 2)
                    #t ; Found it!
                    (loop (+ i 1) new-current-sum remainder-map)))]
             [else
              ; Only store the first occurrence of a remainder
              (hash-set! remainder-map remainder i)
              (loop (+ i 1) new-current-sum remainder-map)]))])))