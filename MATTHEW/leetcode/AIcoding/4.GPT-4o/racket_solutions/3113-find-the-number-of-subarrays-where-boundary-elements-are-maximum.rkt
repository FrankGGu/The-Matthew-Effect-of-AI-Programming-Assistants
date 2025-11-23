(define (count-subarrays nums)
  (define (count-boundary-maximums start end)
    (let loop ((max (list-ref nums start))
               (count 0)
               (i start))
      (if (> i end)
          count
          (begin
            (if (= (list-ref nums i) max)
                (set! count (+ count (- i start 1)))
                (if (> (list-ref nums i) max)
                    (begin
                      (set! max (list-ref nums i))
                      (set! count 0))))
            (loop max count (+ i 1))))))

  (define n (length nums))
  (define result 0)
  (define i 0)
  (while (< i n)
    (let loop ((j i))
      (if (and (< j n) (not (or (and (> j i) (= (list-ref nums j) (list-ref nums i))) 
                                   (and (> j i) (> (list-ref nums j) (list-ref nums i)))))))
          (begin
            (set! result (+ result (count-boundary-maximums i j)))
            (loop (+ j 1)))))
    (set! i (+ i 1)))
  result)

(define (find-number-of-subarrays nums)
  (count-subarrays nums))