#lang racket

(define (smallest-trimmed-numbers nums queries)
  (let* ([num-len (string-length (car nums))]
         [result (make-vector (length queries))])
    (for ([q queries] [q-idx (in-naturals)])
      (let* ([k (car q)]
             [trim (cadr q)]
             [trimmed-indexed-nums
              (for/list ([num (in-list nums)] [original-idx (in-naturals)])
                (let ([start-idx (- num-len trim)])
                  (cons (substring num start-idx num-len) original-idx)))]
             [sorted-trimmed-nums
              (sort trimmed-indexed-nums
                    (lambda (a b)
                      (let ([trimmed-a (car a)]
                            [idx-a (cdr a)]
                            [trimmed-b (car b)]
                            [idx-b (cdr b)])
                        (let ([cmp-result (string-compare trimmed-a trimmed-b)])
                          (or (< cmp-result 0)
                              (and (= cmp-result 0)
                                   (< idx-a idx-b)))))))]
             [ans-pair (list-ref sorted-trimmed-nums (- k 1))]
             [ans-idx (cdr ans-pair)])
        (vector-set! result q-idx ans-idx)))
    (vector->list result)))