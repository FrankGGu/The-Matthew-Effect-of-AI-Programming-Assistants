#lang racket

(define (popcount n)
  (let loop ((num n) (count 0))
    (if (zero? num)
        count
        (loop (bitwise-and num (sub1 num)) (add1 count)))))

(define (string->mask s)
  (let loop ((chars (string->list s))
             (current-mask 0))
    (cond
      ((empty? chars) current-mask)
      (else
       (let* ((c (car chars))
              (bit-pos (- (char->integer c) (char->integer #\a)))
              (bit-to-set (arithmetic-shift 1 bit-pos)))
         (if (bitwise-bit-set? current-mask bit-pos)
             #f
             (loop (cdr chars) (bitwise-ior current-mask bit-to-set))))))))

(define (max-length arr)
  (let* ((masks-with-falses (map string->mask arr))
         (valid-masks (filter identity masks-with-falses)))

    (let ((final-masks (list 0)))

      (for ((mask-s valid-masks))
        (set! final-masks
              (append final-masks
                      (for/list ((existing-mask final-masks)
                                 #:when (zero? (bitwise-and mask-s existing-mask)))
                        (bitwise-ior mask-s existing-mask)))))

      (apply max 0 (map popcount final-masks)))))