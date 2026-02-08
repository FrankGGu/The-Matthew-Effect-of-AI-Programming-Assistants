(define (number-of-nice-subarrays nums k)
  (define (count-subarrays arr k)
    (define (helper arr k start end count)
      (cond
        [(>= start (length arr)) count]
        [else
         (let loop ([i start] [odd-count 0])
           (cond
             [(>= i (length arr)) (helper arr k (+ start 1) end count)]
             [else
              (define new-odd-count (+ odd-count (if (odd? (list-ref arr i)) 1 0)))
              (if (>= new-odd-count k)
                  (helper arr k (+ start 1) end (+ count (- (length arr) i)))
                  (loop (+ i 1) new-odd-count))]))]))
    (helper arr k 0 0 0))
  (count-subarrays nums k))