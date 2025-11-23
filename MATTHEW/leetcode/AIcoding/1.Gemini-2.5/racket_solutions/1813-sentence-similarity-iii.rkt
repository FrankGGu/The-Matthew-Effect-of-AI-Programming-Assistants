(require racket/string)

(define (are-sentences-similar s1 s2)
  (define s1-words (string-split s1 " "))
  (define s2-words (string-split s2 " "))

  (define n1 (length s1-words))
  (define n2 (length s2-words))

  (cond
    ((= n1 n2) (string=? s1 s2))
    ((> n1 n2) (are-sentences-similar s2 s1))
    (else ; n1 < n2
     (let loop-prefix ((l1 s1-words) (l2 s2-words) (prefix-count 0))
       (cond
         ((or (empty? l1) (not (string=? (car l1) (car l2))))
          (let ((prefix-len prefix-count))
            (let ((s1-rev (reverse s1-words))
                  (s2-rev (reverse s2-words)))
              (let loop-suffix ((l1-rev s1-rev) (l2-rev s2-rev) (suffix-count 0))
                (cond
                  ((or (empty? l1-rev) (not (string=? (car l1-rev) (car l2-rev))))
                   (let ((suffix-len suffix-count))
                     (>= (+ prefix-len suffix-len) n1)))
                  (else
                   (loop-suffix (cdr l1-rev) (cdr l2-rev) (+ suffix-count 1))))))))
         (else
          (loop-prefix (cdr l1) (cdr l2) (+ prefix-count 1))))))))