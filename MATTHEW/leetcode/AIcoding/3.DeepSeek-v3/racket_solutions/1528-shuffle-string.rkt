(define/contract (restore-string s indices)
  (-> string? (listof exact-integer?) string?)
  (let* ([n (string-length s)]
         [vec (make-vector n #\space)])
    (for ([i (in-range n)])
      (vector-set! vec (list-ref indices i) (string-ref s i)))
    (list->string (vector->list vec))))