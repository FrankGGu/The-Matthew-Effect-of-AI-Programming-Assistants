(define (find-special-substring s)
  (define (count-occurrences sub str)
    (length (filter (lambda (x) (string=? x sub)) (map (lambda (i) (substring str i (+ i (string-length sub)))) (range 0 (- (string-length str) (string-length sub) -1))))))
  (define (longest-substring len)
    (for*/list ([i (in-range 0 (string-length s))] 
                 [j (in-range (+ i len) (string-length s))])
      (let ([sub (substring s i (+ i len))])
        (when (= (count-occurrences sub s) 3)
          sub))))
  (for*/list ([len (in-range 1 (+ 1 (quotient (string-length s) 3)))])
    (longest-substring len)))

(find-special-substring "abcabcabc")