(define (prev-permutation nums)
  (define n (length nums))
  (define (find-swap-index)
    (let loop ((i (- n 2)))
      (if (< i 0)
          -1
          (if (> (list-ref nums i) (list-ref nums (+ i 1)))
              i
              (loop (- i 1))))))

  (define swap-index (find-swap-index))

  (if (= swap-index -1)
      (reverse! nums)
      (begin
        (define (find-largest-smaller j)
          (let loop ((i (- n 1)))
            (if (< i 0)
                -1
                (if (< (list-ref nums i) (list-ref nums swap-index))
                    i
                    (loop (- i 1))))))

        (define largest-smaller (find-largest-smaller swap-index))
        (let ((temp (list-ref nums swap-index)))
          (set! (list-ref nums swap-index) (list-ref nums largest-smaller))
          (set! (list-ref nums largest-smaller) temp))
        (reverse! (sublist nums (+ swap-index 1)))))))

(define (reverse! lst)
  (define (helper start end)
    (when (< start end)
      (let ((temp (list-ref lst start)))
        (set! (list-ref lst start) (list-ref lst end))
        (set! (list-ref lst end) temp)
        (helper (+ start 1) (- end 1)))))
  (helper 0 (- (length lst) 1)))

(define (sublist lst start)
  (if (null? lst)
      '()
      (if (= start 0)
          lst
          (sublist (cdr lst) (- start 1)))))