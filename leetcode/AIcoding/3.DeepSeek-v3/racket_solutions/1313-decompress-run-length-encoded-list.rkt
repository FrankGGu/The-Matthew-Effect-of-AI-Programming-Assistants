(define/contract (decompress-rle-list nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let loop ([nums nums] [result '()])
    (if (null? nums)
        (reverse result)
        (let* ([freq (car nums)]
               [val (cadr nums)]
               [new-elements (make-list freq val)])
          (loop (cddr nums) (append new-elements result))))))