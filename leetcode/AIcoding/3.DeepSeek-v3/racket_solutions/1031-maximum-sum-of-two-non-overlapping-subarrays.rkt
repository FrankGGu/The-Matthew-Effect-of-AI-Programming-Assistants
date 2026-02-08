(define/contract (max-sum-two-no-overlap nums firstLen secondLen)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (define n (length nums))
  (define prefix (make-vector (+ n 1) 0))
  (for ([i (in-range 1 (+ n 1))])
    (vector-set! prefix i (+ (vector-ref prefix (- i 1)) (list-ref nums (- i 1)))))

  (define (sum i j)
    (- (vector-ref prefix j) (vector-ref prefix i)))

  (define max-first 0)
  (define max-second 0)
  (define result 0)

  (for ([i (in-range firstLen (+ (- n secondLen) 1))])
    (set! max-first (max max-first (sum (- i firstLen) i)))
    (set! result (max result (+ max-first (sum i (+ i secondLen)))))

  (for ([i (in-range secondLen (+ (- n firstLen) 1))])
    (set! max-second (max max-second (sum (- i secondLen) i)))
    (set! result (max result (+ max-second (sum i (+ i firstLen)))))

  result)