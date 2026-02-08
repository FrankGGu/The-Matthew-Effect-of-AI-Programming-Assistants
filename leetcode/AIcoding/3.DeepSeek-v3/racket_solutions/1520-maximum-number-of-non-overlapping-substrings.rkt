(define/contract (max-num-of-substrings s)
  (-> string? (listof string?))
  (let* ([n (string-length s)]
         [first-occ (make-hash)]
         [last-occ (make-hash)])
    (for ([i (in-range n)])
      (let ([c (string-ref s i)])
        (unless (hash-has-key? first-occ c)
          (hash-set! first-occ c i))
        (hash-set! last-occ c i))
    (let ([intervals '()])
      (for ([(c _) (in-hash first-occ)])
        (let ([start (hash-ref first-occ c)]
              [end (hash-ref last-occ c)])
          (let loop ([new-start start]
                     [new-end end]
                     [changed? #t])
            (if changed?
                (let ([newest-start new-start]
                      [newest-end new-end])
                  (for ([i (in-range new-start (add1 new-end))])
                    (let ([curr-c (string-ref s i)])
                      (set! newest-start (min newest-start (hash-ref first-occ curr-c)))
                      (set! newest-end (max newest-end (hash-ref last-occ curr-c)))))
                  (if (and (= newest-start new-start) (= newest-end new-end))
                      (loop newest-start newest-end #f)
                      (loop newest-start newest-end #t)))
                (set! intervals (cons (cons new-start new-end) intervals))))))
      (let* ([sorted-intervals (sort intervals (lambda (a b) (< (cdr a) (cdr b))))]
             [result '()]
             [prev-end -1])
        (for ([interval (in-list sorted-intervals)])
          (let ([current-start (car interval)]
                [current-end (cdr interval)])
            (when (> current-start prev-end)
              (set! result (cons (substring s current-start (add1 current-end)) result))
              (set! prev-end current-end))))
        (reverse result)))))