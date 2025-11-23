#lang racket

(define (check-if-digits-equal-after-operations s k)
  (define (sum-digits-in-groups current-s k-val)
    (let* ((len (string-length current-s))
           (new-s-parts '()))
      (for ((i (in-range 0 len k-val)))
        (let* ((end (min (+ i k-val) len))
               (group-str (substring current-s i end))
               (group-sum 0))
          (for ((char (in-string group-str)))
            (set! group-sum (+ group-sum (- (char->integer char) (char->integer #\0)))))
          (set! new-s-parts (cons (number->string group-sum) new-s-parts))))
      (apply string-append (reverse new-s-parts))))

  (let loop ((current-s s))
    (if (<= (string-length current-s) k)
        (if (equal? (string-length current-s) 0)
            #t
            (let ((first-char (string-ref current-s 0)))
              (for/all ((char (in-string current-s)))
                (char=? char first-char))))
        (loop (sum-digits-in-groups current-s k)))))