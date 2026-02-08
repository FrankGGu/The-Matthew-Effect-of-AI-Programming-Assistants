(define (maximum-score s x y)
  (define (solve s a b score)
    (cond
      [(empty? s) score]
      [else
       (define (find-ab s)
         (let loop ([s s] [idx 0])
           (cond
             [(empty? s) #f]
             [(= (string-length s) 1) #f]
             [(and (char=? (string-ref s 0) a) (char=? (string-ref s 1) b)) idx]
             [else (loop (substring s 1) (+ idx 1))])))

       (define (find-ba s)
         (let loop ([s s] [idx 0])
           (cond
             [(empty? s) #f]
             [(= (string-length s) 1) #f]
             [(and (char=? (string-ref s 0) b) (char=? (string-ref s 1) a)) idx]
             [else (loop (substring s 1) (+ idx 1))])))

       (cond
         [(> x y)
          (let ([ab-idx (find-ab s)])
            (cond
              [ab-idx
               (solve (string-append (substring s 0 ab-idx) (substring s (+ ab-idx 2))) a b (+ score x))]
              [else
               (let ([ba-idx (find-ba s)])
                 (cond
                   [ba-idx
                    (solve (string-append (substring s 0 ba-idx) (substring s (+ ba-idx 2))) a b (+ score y))]
                   [else score]))]))]
         [else
          (let ([ba-idx (find-ba s)])
            (cond
              [ba-idx
               (solve (string-append (substring s 0 ba-idx) (substring s (+ ba-idx 2))) a b (+ score y))]
              [else
               (let ([ab-idx (find-ab s)])
                 (cond
                   [ab-idx
                    (solve (string-append (substring s 0 ab-idx) (substring s (+ ab-idx 2))) a b (+ score x))]
                   [else score]))]))])]])))

  (solve s #\a #\b 0))