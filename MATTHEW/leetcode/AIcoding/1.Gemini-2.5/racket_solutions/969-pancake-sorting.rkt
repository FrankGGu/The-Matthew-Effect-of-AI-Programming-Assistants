#lang racket

(define (flip arr k)
  (let* ([prefix (take arr k)]
         [suffix (drop arr k)]
         [reversed-prefix (reverse prefix)])
    (append reversed-prefix suffix)))

(define (find-index val lst)
  (let loop ([lst lst] [idx 0])
    (cond
      [(empty? lst) -1]
      [(= (car lst) val) idx]
      [else (loop (cdr lst) (+ idx 1))])))

(define (pancake-sort arr)
  (let ([n (length arr)])
    (let loop ([current-n n] [current-arr arr] [result '()])
      (cond
        [(= current-n 0) result]
        [else
         (let* ([target-val current-n]
                [idx (find-index target-val (take current-arr current-n))])
           (if (= idx (- current-n 1)) ; Target element is already in its correct sorted position
               (loop (- current-n 1) current-arr result)
               (let-values ([(new-arr new-flips)]
                            (if (> idx 0) ; If target is not at the front, bring it to the front
                                (let* ([k1 (+ idx 1)]
                                       [arr-after-k1 (flip current-arr k1)])
                                  ; Then bring it to its final position
                                  (values (flip arr-after-k1 current-n) (list k1 current-n)))
                                ; If target is already at the front (idx = 0), only one flip needed
                                (values (flip current-arr current-n) (list current-n))))
                 (loop (- current-n 1)
                       new-arr
                       (append result new-flips)))))]))))