(define (buddy-strings A B)
  (if (or (not (= (string-length A) (string-length B)))
          (and (string=? A B) (not (has-duplicate? A))))
      #f
      (let loop ((i 0) (diff '()))
        (cond
          [(= i (string-length A)) 
           (and (= (length diff) 2)
                (string=? (string-append (substring A (car diff)) (substring A (cadr diff))) 
                           (string-append (substring B (car diff)) (substring B (cadr diff)))))]
          [(not (string=? (string-ref A i) (string-ref B i))) 
           (loop (+ i 1) (cons i diff))]
          [else 
           (loop (+ i 1) diff)])))))

(define (has-duplicate? str)
  (define seen (make-hash))
  (for ([i (in-range (string-length str))])
    (let ([c (string-ref str i)])
      (if (hash-has-key? seen c)
          (return #t)
          (hash-set! seen c #t))))
  #f)