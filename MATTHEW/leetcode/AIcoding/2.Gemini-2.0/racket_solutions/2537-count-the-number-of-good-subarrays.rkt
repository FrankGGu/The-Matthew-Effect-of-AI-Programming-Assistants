(define (count-good-subarrays nums k)
  (define (count-subarrays start end current-xor count)
    (cond [(>= start (length nums)) count]
          [else (define new-xor (bitwise-xor current-xor (list-ref nums start)))
                (if (>= (hash-count (hash-ref freq-map new-xor 0)) k)
                    (count-subarrays (+ start 1) end current-xor (+ count (- (length nums) start)))
                    (count-subarrays (+ start 1) end current-xor count))]))

  (define (build-freq-map nums)
    (define freq-map (make-hash))
    (for ([num nums])
      (hash-update! freq-map num (lambda (v) (if (null? v) 1 (+ v 1))) 0))
    freq-map)

  (define freq-map (build-freq-map nums))
  (count-subarrays 0 (length nums) 0 0))