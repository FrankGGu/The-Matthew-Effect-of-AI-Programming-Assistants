(define (add-operators num target)
  (define results '())

  (define (backtrack index current-path current-value last-operand)
    (cond
      ((= index (string-length num))
       (when (= current-value target)
         (set! results (cons current-path results))))
      (else
       (for ([i (in-range index (string-length num))])
         (define sub-str (substring num index (add1 i)))
         (when (and (> (string-length sub-str) 1)
                    (char=? (stringref sub-str 0) #\0))
           (break))

         (define current-num-val (string->number sub-str))

         (if (= index 0)
             (backtrack (add1 i) sub-str current-num-val current-num-val)
             (begin
               (backtrack (add1 i)
                          (string-append current-path "+" sub-str)
                          (+ current-value current-num-val)
                          current-num-val)
               (backtrack (add1 i)
                          (string-append current-path "-" sub-str)
                          (- current-value current-num-val)
                          (- 0 current-num-val))
               (backtrack (add1 i)
                          (string-append current-path "*" sub-str)
                          (+ (- current-value last-operand)
                             (* last-operand current-num-val))
                          (* last-operand current-num-val))))))))

  (backtrack 0 "" 0 0)
  (reverse results))