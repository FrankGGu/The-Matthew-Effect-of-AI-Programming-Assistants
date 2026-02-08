(define (makeArrayEmpty arr)
  (define (helper arr count)
    (if (null? arr)
        count
        (let ((first (car arr)))
          (if (= first (car (cdr arr)))
              (helper (cdr arr) (+ count 1))
              (helper (cdr arr) count)))))
  (helper arr 0))

(define (arrayEmpty arr)
  (makeArrayEmpty arr))