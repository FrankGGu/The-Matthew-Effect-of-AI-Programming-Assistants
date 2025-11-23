#lang racket

(define (number-of-substrings s)
  (let* ((n (string-length s))
         (freq (make-vector 3 0)) ; 0: 'a', 1: 'b', 2: 'c'
         (left 0)
         (ans 0))
    (for ([right (in-range n)])
      (let ((char-idx (- (char->integer (string-ref s right)) (char->integer #\a))))
        (vector-set! freq char-idx (+ (vector-ref freq char-idx) 1)))

      (let loop ()
        (when (and (> (vector-ref freq 0) 0)
                   (> (vector-ref freq 1) 0)
                   (> (vector-ref freq 2) 0))
          (set! ans (+ ans (- n right)))

          (let ((left-char-idx (- (char->integer (string-ref s left)) (char->integer #\a))))
            (vector-set! freq left-char-idx (- (vector-ref freq left-char-idx) 1)))
          (set! left (+ left 1))
          (loop))))
    ans))