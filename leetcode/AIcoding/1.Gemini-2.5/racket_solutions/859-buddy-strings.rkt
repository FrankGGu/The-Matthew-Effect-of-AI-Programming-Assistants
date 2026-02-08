#lang racket

(define (buddy-strings s goal)
  (let ([len-s (string-length s)]
        [len-goal (string-length goal)])

    (if (not (= len-s len-goal))
        #f
        (cond
          [(string=? s goal)
           (let* ([chars (string->list s)]
                  [char-set (list->set chars)])
             (> (length chars) (set-count char-set)))]
          [else
           (let ([diff-indices (for/list ([i (in-range len-s)]
                                          #:when (not (char=? (string-ref s i) (string-ref goal i))))
                                 i)])
             (and (= (length diff-indices) 2)
                  (let ([i1 (car diff-indices)]
                        [i2 (cadr diff-indices)])
                    (and (char=? (string-ref s i1) (string-ref goal i2))
                         (char=? (string-ref s i2) (string-ref goal i1))))))]))))