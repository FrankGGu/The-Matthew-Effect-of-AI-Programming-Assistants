(define (shiftingLetters s shifts)
  (define n (string-length s))
  (define shift-sums (make-vector n 0))
  (for ((i (in-range (length shifts))))
    (let ((shift (vector-ref shifts i)))
      (vector-set! shift-sums i shift)))
  (for ((i (in-range (- (length shifts) 1) -1 -1)))
    (vector-set! shift-sums i
      (+ (vector-ref shift-sums i)
         (vector-ref shift-sums (+ i 1)))))
  (define result (string->list s))
  (for ((i (in-range n)))
    (let ((shift (modulo (vector-ref shift-sums i) 26)))
      (vector-set! result i
        (integer->char
          (modulo (+ (char->integer (list-ref result i)) shift 97) 26)))))
  (list->string result))

(define (shiftingLetters-main s shifts)
  (shiftingLetters s (map (λ (x) (car x)) shifts)))