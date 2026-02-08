(define (are-almost-equal s1 s2)
  (if (not (= (string-length s1) (string-length s2)))
      #f
      (let loop ((i 0) (diff '()))
        (cond ((= i (string-length s1)) 
               (and (= (length diff) 2)
                    (equal? (list (list-ref s1 (car diff)) (list-ref s2 (car diff))) 
                            (list (list-ref s2 (cadr diff)) (list-ref s1 (cadr diff)))))
               )
              ((char=? (string-ref s1 i) (string-ref s2 i)) 
               (loop (+ i 1) diff))
              (else 
               (loop (+ i 1) (cons i diff))))))))

(define (is-swap-possible s1 s2)
  (are-almost-equal s1 s2))