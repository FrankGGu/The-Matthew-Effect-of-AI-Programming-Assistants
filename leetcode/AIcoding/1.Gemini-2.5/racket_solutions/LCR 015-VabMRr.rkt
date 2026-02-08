#lang racket

(define (find-anagrams s p)
  (let* ((n (string-length s))
         (m (string-length p)))
    (if (> m n) '()
        (let* ((p-freq (make-vector 26 0))
               (s-freq (make-vector 26 0))
               (result '())
               (a-char-code (char->integer #\a)))

          (for ([i (in-range m)])
            (define char-code (- (char->integer (string-ref p i)) a-char-code))
            (vector-set! p-freq char-code (+ (vector-ref p-freq char-code) 1)))

          (for ([i (in-range m)])
            (define char-code (- (char->integer (string-ref s i)) a-char-code))
            (vector-set! s-freq char-code (+ (vector-ref s-freq char-code) 1)))

          (when (equal? p-freq s-freq)
            (set! result (cons 0 result)))

          (for ([left (in-range 1 (- n m -1))])
            (define right (+ left m -1))
            (define char-to-remove-code (- (char->integer (string-ref s (- left 1))) a-char-code))
            (define char-to-add-code (- (char->integer (string-ref s right)) a-char-code))

            (vector-set! s-freq char-to-remove-code (- (vector-ref s-freq char-to-remove-code) 1))
            (vector-set! s-freq char-to-add-code (+ (vector-ref s-freq char-to-add-code) 1))

            (when (equal? p-freq s-freq)
              (set! result (cons left result))))

          (reverse result))))