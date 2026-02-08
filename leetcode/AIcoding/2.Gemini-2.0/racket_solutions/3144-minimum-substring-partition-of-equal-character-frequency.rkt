(define (min-substring-partition s)
  (define (equal-frequency? str)
    (if (string=? str "")
        #t
        (let* ((counts (make-hash))
               (n (string-length str)))
          (for ([i (in-range n)])
            (let ((char (string-ref str i)))
              (hash-update! counts char (λ (v) (+ v 1)) 1)))
          (let ((frequencies (hash-values counts)))
            (if (null? frequencies)
                #t
                (let ((first-freq (car frequencies)))
                  (andmap (λ (freq) (= freq first-freq)) frequencies)))))))

  (define (solve s)
    (cond
      [(string=? s "") 0]
      [(equal-frequency? s) 1]
      [else
       (let ((n (string-length s)))
         (let loop ([i 1])
           (cond
             [(>= i n) (+ 1 (solve (substring s 1 n)))]
             [(equal-frequency? (substring s 0 i))
              (+ 1 (solve (substring s i n)))]
             [else (loop (+ i 1))])))]))

  (solve s))