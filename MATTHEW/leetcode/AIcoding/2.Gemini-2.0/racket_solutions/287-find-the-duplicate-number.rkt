(define (find-duplicate nums)
  (define (tortoise-and-hare nums)
    (let loop ([tortoise (list-ref nums 0)]
               [hare (list-ref nums (list-ref nums 0))])
      (if (equal? tortoise hare)
          tortoise
          (loop (list-ref nums tortoise) (list-ref nums (list-ref nums hare))))))

  (define (find-entrance nums meeting-point)
    (let loop ([ptr1 (list-ref nums 0)]
               [ptr2 meeting-point])
      (if (equal? ptr1 ptr2)
          ptr1
          (loop (list-ref nums ptr1) (list-ref nums ptr2)))))

  (let ([meeting-point (tortoise-and-hare nums)])
    (find-entrance nums meeting-point)))