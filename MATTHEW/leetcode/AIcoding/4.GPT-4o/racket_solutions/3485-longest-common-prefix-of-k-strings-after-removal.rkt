(define (longestCommonPrefix strs)
  (if (null? strs) ""
      (let loop ((prefix (car strs)) (rest (cdr strs)))
        (if (null? rest) prefix
            (let* ((next (car rest))
                   (new-prefix (take-while (lambda (x y) (equal? x y)) 
                                             (map list prefix next))))
              (if (null? new-prefix) ""
                  (loop (apply string-append new-prefix) (cdr rest))))))))

(define (take-while pred lst)
  (if (or (null? lst) (not (pred (car lst))))
      '()
      (cons (car lst) (take-while pred (cdr lst)))))

(define (longestCommonPrefixAfterRemoval strs k)
  (let ((filtered-strs (filter (lambda (s) (<= (string-length s) k)) strs)))
    (longestCommonPrefix filtered-strs)))

(longestCommonPrefixAfterRemoval '("flower" "flow" "flight") 5)