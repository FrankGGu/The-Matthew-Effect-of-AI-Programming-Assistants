(define (findPaths m n maxMove startRow startColumn)
  (define MOD 1000000007)
  (define memo (make-hash))

  (define (dp r c moves)
    (cond
      ((or (< r 0) (>= r m) (< c 0) (>= c n)) 1)
      ((= moves 0) 0)
      (else
       (let ((key (list r c moves)))
         (case (hash-ref memo key #f)
           ((#f)
            (let* ((res (+ (dp (- r 1) c (- moves 1))
                           (dp (+ r 1) c (- moves 1))
                           (dp r (- c 1) (- moves 1))
                           (dp r (+ c 1) (- moves 1))))
                   (final-res (modulo res MOD)))
              (hash-set! memo key final-res)
              final-res))
           (else
            (hash-ref memo key)))))))

  (dp startRow startColumn maxMove))