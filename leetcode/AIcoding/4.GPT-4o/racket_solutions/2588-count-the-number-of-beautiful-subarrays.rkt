(define (beautiful-subarrays nums)
  (define (count-beautiful-subarrays nums)
    (let loop ((prefix-sum (list 0))
               (count 0)
               (result 0))
      (if (null? nums)
          result
          (let* ((x (car nums))
                 (new-prefix-sum (+ (car prefix-sum) x))
                 (new-count (if (= new-prefix-sum 0) (+ count 1) count)))
            (loop (cons new-prefix-sum prefix-sum)
                  new-count
                  (+ result new-count))))))
  (count-beautiful-subarrays nums))

(define (count-beautiful-subarrays-main nums)
  (beautiful-subarrays nums))

(define (main)
  (count-beautiful-subarrays-main (list 1 1 1 0 1 0 0 1)))

(main)