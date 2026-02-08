(define (are-almost-equal s1 s2)
  (let loop ((i 0)
             (diff '()))
    (cond
      [(= i (string-length s1)) (or (null? diff) (and (= (length diff) 2)
                                                     (char=? (car (first diff)) (cadr (second diff)))
                                                     (char=? (cadr (first diff)) (car (second diff)))))]
      [(char=? (string-ref s1 i) (string-ref s2 i)) (loop (add1 i) diff)]
      [else (if (>= (length diff) 2)
                #f
                (loop (add1 i) (cons (list (string-ref s1 i) (string-ref s2 i)) diff)))])))