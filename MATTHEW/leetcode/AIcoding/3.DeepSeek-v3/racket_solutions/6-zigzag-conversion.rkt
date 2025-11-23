(define (convert s numRows)
  (if (or (= numRows 1) (>= numRows (string-length s)))
      s
      (let* ([rows (make-vector numRows "")]
             [current-row 0]
             [going-down? #f])
        (for ([c (in-string s)])
          (vector-set! rows current-row 
                       (string-append (vector-ref rows current-row) (string c)))
          (if (or (= current-row 0) (= current-row (- numRows 1)))
              (set! going-down? (not going-down?))
              (void)
          (set! current-row (if going-down? (+ current-row 1) (- current-row 1)))
        ))
        (apply string-append (vector->list rows)))))