(define (can-place-flowers flowerbed n)
  (define (helper flowerbed n i)
    (cond
      [(>= i (length flowerbed)) (= n 0)]
      [(> n 0)
       (cond
         [(and (= (list-ref flowerbed i) 0)
               (or (= i 0) (= (list-ref flowerbed (- i 1)) 0))
               (or (= i (- (length flowerbed) 1)) (= (list-ref flowerbed (+ i 1)) 0)))
          (helper flowerbed (- n 1) (+ i 2))]
         [else
          (helper flowerbed n (+ i 1))])]
      [else #t]))

  (helper flowerbed n 0))