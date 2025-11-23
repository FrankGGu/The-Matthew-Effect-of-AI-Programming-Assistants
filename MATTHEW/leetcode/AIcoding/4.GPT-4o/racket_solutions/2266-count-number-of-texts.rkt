(define (countTexts pressedKeys)
  (define n (string-length pressedKeys))
  (define mod 1000000007)
  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 0 1)
  (define (valid? k chars)
    (and (<= 0 k) (< k chars)))
  (for ([i (in-range 1 (+ n 1))])
    (define current-key (char->integer (string-ref pressedKeys (- i 1))))
    (define max-presses 
      (cond
        [(member current-key '(49)) 1]
        [(member current-key '(50)) 2]
        [(member current-key '(51)) 3]
        [(member current-key '(52)) 3]
        [(member current-key '(53)) 4]
        [(member current-key '(54)) 4]
        [(member current-key '(55)) 4]
        [(member current-key '(56)) 3]
        [(member current-key '(57)) 1]
        [else 0]))
    (for ([j (in-range 1 (+ 1 max-presses))])
      (when (valid? (- i j) 0)
        (vector-set! dp i 
          (mod (+ (vector-ref dp i) (vector-ref dp (- i j))) mod)))))
  (vector-ref dp n))

(define (countTexts-main)
  (define pressedKeys "22233")
  (countTexts pressedKeys))

(countTexts-main)