(define (find-kth-largest nums k)
  (let* ([nums-str (map number->string nums)]
         [sorted (sort nums-str 
                      (lambda (a b)
                        (or (> (string-length a) (string-length b))
                            (and (= (string-length a) (string-length b))
                                 (string>? a b)))))])
    (string->number (list-ref sorted (- k 1)))))