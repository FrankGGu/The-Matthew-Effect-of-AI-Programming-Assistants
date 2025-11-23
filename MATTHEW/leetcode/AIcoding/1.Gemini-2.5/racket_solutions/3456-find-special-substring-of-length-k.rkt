#lang racket

(define (is-special? s k)
  (cond
    ((= k 0) #f)
    ((= k 1) #t)
    (else
     (let ((first-char (string-ref s 0)))
       ;; Check if all characters are the same
       (let loop-all-same ((i 1))
         (cond
           ((= i k) #t) ; All characters are the same
           ((char=? (string-ref s i) first-char) (loop-all-same (+ i 1)))
           (else
            ;; Not all characters are the same.
            ;; Check if it's type 2: all same except middle, and k is odd.
            (if (odd? k)
                (let ((mid-idx (floor (/ k 2))))
                  (let loop-mid-diff ((i 0))
                    (cond
                      ((= i k) #t)
                      ((= i mid-idx) (loop-mid-diff (+ i 1)))
                      ((char=? (string-ref s i) first-char) (loop-mid-diff (+ i 1)))
                      (else #f))))
                #f))))))))

(define (find-special-substring-of-length-k s k)
  (let ((n (string-length s)))
    (if (< n k)
        #f
        (let loop ((i 0))
          (cond
            ((> (+ i k) n) #f)
            (else
             (let ((sub (substring s i (+ i k))))
               (if (is-special? sub k)
                   #t
                   (loop (+ i 1))))))))))