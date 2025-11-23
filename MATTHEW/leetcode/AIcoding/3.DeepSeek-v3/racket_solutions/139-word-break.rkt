(define/contract (word-break s wordDict)
  (-> string? (listof string?) boolean?)
  (let ([word-set (list->set wordDict)]
        [n (string-length s)])
    (let dp ([start 0])
      (cond
        [(= start n) #t]
        [else
         (for/or ([end (in-range (add1 start) (add1 n))])
           (and (set-member? word-set (substring s start end))
                (dp end)))]))))