#lang racket

(define (get-pos char-idx)
  (if (< char-idx 24)
      (list (quotient char-idx 6) (remainder char-idx 6))
      (list 4 (- char-idx 24))))

(define (manhattan-distance pos1-idx pos2-idx)
  (if (= pos1-idx -1)
      0
      (let* ((p1 (get-pos pos1-idx))
             (p2 (get-pos pos2-idx))
             (r1 (car p1))
             (c1 (cadr p1))
             (r2 (car p2))
             (c2 (cadr p2)))
        (+ (abs (- r1 r2)) (abs (- c1 c2))))))

(define (minimum-distance word)
  (let* ((n (string-length word))
         (memo (make-hash)))

    (define (dp index f1-pos f2-pos)
      (cond
        ((= index n) 0)
        (else
         (let ((memo-key (list index f1-pos f2-pos)))
           (hash-ref! memo memo-key
                      (lambda ()
                        (let* ((char-to-type-idx (- (char->integer (string-ref word index)) (char->integer #\A)))
                               (cost-f1 (manhattan-distance f1-pos char-to-type-idx))
                               (cost-f2 (manhattan-distance f2-pos char-to-type-idx)))

                          (min
                           (+ cost-f1 (dp (+ index 1) char-to-type-idx f2-pos))
                           (+ cost-f2 (dp (+ index 1) f1-pos char-to-type-idx))))))))))

    (dp 0 -1 -1)))