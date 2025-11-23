(define (generate-binary-strings n)
  (define (helper k last-digit)
    (cond
      [(= k n) (list "")]
      [else
       (let ([zeros (if (= last-digit 0) '() (map (lambda (s) (string-append "0" s)) (helper (+ k 1) 0)))]
             [ones (map (lambda (s) (string-append "1" s)) (helper (+ k 1) 1))])
         (append zeros ones))]))
  (append (map (lambda (s) (string-append "0" s)) (helper 1 0))
          (map (lambda (s) (string-append "1" s)) (helper 1 1))))

(define (find-binary-strings n)
  (cond
    [(= n 1) (list "0" "1")]
    [else
     (let ([prev (find-binary-strings (- n 1))])
       (append (filter (lambda (s) (not (string=? (substring s (- (string-length s) 1) (string-length s)) "0")) (map (lambda (s) (string-append s "0")) prev))
               (map (lambda (s) (string-append s "1")) prev)))]))