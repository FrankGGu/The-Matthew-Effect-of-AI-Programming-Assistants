(define (findShortestSuperstring strs)
  (define (overlap a b)
    (let loop ((i (min (string-length a) (string-length b))) (max-overlap 0))
      (if (zero? i)
          max-overlap
          (if (string=? (substring a (- (string-length a) i)) (substring b 0 i))
              (loop (sub1 i) i)
              (loop (sub1 i) max-overlap)))))

  (define (merge a b)
    (if (string=? a "")
        b
        (string-append a (substring b (overlap a b)))))

  (define (dp masks)
    (for/fold ([best ""]) ([mask masks])
      (define current (filter (lambda (s) (bitwise-and mask (ash 1 (string->number (string->list s 0))))) strs))
      (define merged (foldl merge "" current))
      (if (or (string=? best "") (> (string-length merged) (string-length best)))
          merged
          best)))

  (define (bitmasking)
    (let loop ((mask 0) (results '()))
      (if (= mask (expt 2 (length strs)))
          results
          (loop (add1 mask) (cons (dp (list mask)) results)))))

  (let* ((result (bitmasking)))
    (if (null? result)
        ""
        (apply max result))))

(findShortestSuperstring '("alex", "loves", "leetcode"))