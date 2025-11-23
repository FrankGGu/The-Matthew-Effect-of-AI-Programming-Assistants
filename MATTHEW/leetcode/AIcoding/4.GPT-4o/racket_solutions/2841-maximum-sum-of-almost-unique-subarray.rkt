(define (maximumSum(nums))
  (define (helper nums)
    (let loop ((start 0) (end 0) (current-sum 0) (max-sum 0) (seen (make-hash)))
      (if (< end (length nums))
          (begin
            (set! current-sum (+ current-sum (list-ref nums end)))
            (hash-set! seen (list-ref nums end) (+ (hash-ref seen (list-ref nums end) 0) 1))
            (if (> (hash-ref seen (list-ref nums end)) 1)
                (begin
                  (set! current-sum (loop-helper start end current-sum seen))
                  (set! start (add1 start)))
                (set! max-sum (max max-sum current-sum)))
            (loop start (add1 end) current-sum max-sum seen))
          max-sum)))

  (define (loop-helper start end current-sum seen)
    (let loop ((new-start start))
      (if (< new-start end)
          (begin
            (set! current-sum (- current-sum (list-ref nums new-start)))
            (hash-set! seen (list-ref nums new-start) (- (hash-ref seen (list-ref nums new-start)) 1))
            (if (= (hash-ref seen (list-ref nums new-start)) 1)
                (loop end)
                (loop (add1 new-start))))
          current-sum)))

  (helper nums))