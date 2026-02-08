(define (numSubarraysWithSum A S)
  (define (at-most-k A k)
    (let loop ((start 0) (end 0) (count 0) (result 0))
      (cond
        ((= end (length A)) result)
        (else
          (if (> (apply + (sublist A start end)) k)
              (loop (add1 start) end count result)
              (loop start (add1 end) (+ count (if (= (list-ref A end) 1) 1 0)) (+ result count)))))))
  (- (at-most-k A S) (at-most-k A (- S 1)))
)

(numSubarraysWithSum '(1 0 1 0 1) 2)