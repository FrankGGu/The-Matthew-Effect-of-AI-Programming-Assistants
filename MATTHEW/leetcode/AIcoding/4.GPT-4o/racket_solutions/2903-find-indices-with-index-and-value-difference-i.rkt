(define (find-indices nums diff)
  (let loop ((i 0) (result '()))
    (if (>= i (length nums))
        result
        (let ((current (list-ref nums i)))
          (if (and (not (null? result))
                   (= current (list-ref nums (+ i diff))))
              (loop (+ i 1) (cons i result))
              (loop (+ i 1) result))))))

(define (find-indices-with-diff nums diff)
  (reverse (find-indices nums diff)))