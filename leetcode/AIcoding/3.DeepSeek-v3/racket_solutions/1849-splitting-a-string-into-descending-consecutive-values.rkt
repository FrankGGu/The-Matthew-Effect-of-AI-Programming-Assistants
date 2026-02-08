(define (split-string s)
  (define (helper start prev)
    (cond
      [(= start (string-length s)) #t]
      [else
       (for/or ([end (in-range (add1 start) (add1 (string-length s)))])
         (define num (string->number (substring s start end)))
         (and (not (false? num))
              (or (false? prev)
                  (= num (sub1 prev)))
              (helper end num)))]))
  (for/or ([i (in-range 1 (string-length s))])
    (define first-num (string->number (substring s 0 i)))
    (and (not (false? first-num))
         (helper i first-num))))