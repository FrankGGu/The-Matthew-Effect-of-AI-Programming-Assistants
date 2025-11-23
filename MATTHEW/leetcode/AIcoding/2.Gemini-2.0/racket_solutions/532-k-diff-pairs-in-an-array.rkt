(define (find-pairs nums k)
  (let* ((nums (sort nums <))
         (count 0)
         (seen (make-hash)))
    (for ([i (in-range (length nums))])
      (for ([j (in-range (+ i 1) (length nums))])
        (let [(diff (- (list-ref nums j) (list-ref nums i)))]
          (when (= diff k)
            (let [(pair (cons (list-ref nums i) (list-ref nums j)))]
              (unless (hash-has-key? seen pair)
                (hash-set! seen pair #t)
                (set! count (+ count 1))))))))
    count))