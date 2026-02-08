(define (getDataFrameSize df)
  (list (length df) (if (null? df) 0 (length (first df)))))