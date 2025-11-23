(define (maximum-subarray-sum-with-one-deletion nums)
  (define n (length nums))
  (define (max-subarray-sum arr)
    (let loop ([i 1] [max-so-far (car arr)] [curr-max (car arr)])
      (if (= i (length arr))
          max-so-far
          (let ([new-curr-max (max (car (list-ref arr i)) (+ curr-max (car (list-ref arr i))))])
            (loop (+ i 1) (max max-so-far new-curr-max) new-curr-max)))))
  (define dp-left (make-vector n 0))
  (define dp-right (make-vector n 0))
  (vector-set! dp-left 0 (car nums))
  (vector-set! dp-right (- n 1) (car (list-ref nums (- n 1))))
  (define max-left (car nums))
  (define max-right (car (list-ref nums (- n 1))))

  (for ([i (in-range 1 n)])
    (let ([val (car (list-ref nums i))])
      (vector-set! dp-left i (max val (+ (vector-ref dp-left (- i 1)) val)))
      (set! max-left (max max-left (vector-ref dp-left i)))))

  (for ([i (in-range (- n 2) -1 -1)])
    (let ([val (car (list-ref nums i))])
      (vector-set! dp-right i (max val (+ (vector-ref dp-right (+ i 1)) val)))
      (set! max-right (max max-right (vector-ref dp-right i)))))

  (define ans max-left)

  (for ([i (in-range 1 (- n 1))])
    (set! ans (max ans (+ (vector-ref dp-left (- i 1)) (vector-ref dp-right (+ i 1))))))

  (if (and (= n 1) (< (car nums) 0)) 0 ans)
  (if (= n 1) (car nums) ans)
  )