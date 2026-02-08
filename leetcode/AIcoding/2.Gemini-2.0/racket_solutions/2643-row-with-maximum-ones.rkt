(define (row-and-maximum-ones mat)
  (let loop ([rows (length mat)]
             [cols (length (car mat))]
             [i 0]
             [max-ones 0]
             [max-index 0])
    (if (= i rows)
        (list max-index max-ones)
        (let* ([row (list-ref mat i)]
               [ones (count (lambda (x) (= x 1)) row)])
          (if (> ones max-ones)
              (loop rows cols (+ i 1) ones i)
              (loop rows cols (+ i 1) max-ones max-index))))))