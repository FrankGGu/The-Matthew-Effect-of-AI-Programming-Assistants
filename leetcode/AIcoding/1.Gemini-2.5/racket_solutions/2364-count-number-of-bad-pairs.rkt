(define (count-bad-pairs nums)
  (let* ([n (length nums)]
         [total-pairs (if (< n 2) 0 (/ (* n (- n 1)) 2))]
         [freq (make-hash)])

    (for ([val (in-indexed nums)]
          [i (in-naturals)])
      (hash-update! freq (- val i) add1 0))

    (let ([good-pairs 0])
      (hash-for-each
       freq
       (lambda (key count)
         (set! good-pairs (+ good-pairs (if (< count 2) 0 (/ (* count (- count 1)) 2)))))
       )

      (- total-pairs good-pairs))))