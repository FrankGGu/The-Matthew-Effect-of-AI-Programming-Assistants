(define (number-of-powerful-integer start finish limit s)
  (define (count n s)
    (define s-str (number->string s))
    (define s-len (string-length s-str))
    (define (helper pos tight last-digit)
      (cond
        [(= pos (string-length n)) 
         (if (>= last-digit limit) 1 0)]
        [else
         (define current-digit (string->number (string (string-ref n pos))))
         (define upper (if tight current-digit 9))
         (define res 0)
         (for ([d (in-range 0 (add1 upper))])
           (define new-tight (and tight (= d upper)))
           (define new-last-digit 
             (if (and (>= pos (- (string-length n) s-len)) 
                 (string->number (substring n pos (min (string-length n) (+ pos s-len)))))
                 d))
           (when (or (< pos (- (string-length n) s-len)) 
                     (and (>= pos (- (string-length n) s-len)) 
                          (>= new-last-digit limit)))
             (set! res (+ res (helper (add1 pos) new-tight new-last-digit))))
         res)]))
    (helper 0 #t 0))

  (define (to-string x) (number->string x))
  (- (count (to-string finish) s) (count (to-string (sub1 start)) s)))