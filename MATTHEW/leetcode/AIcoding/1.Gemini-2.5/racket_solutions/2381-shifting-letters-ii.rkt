(define (shifting-letters s shifts)
  (define n (string-length s))
  (define deltas (make-vector n 0))

  (for-each (lambda (shift)
              (define start (car shift))
              (define end (cadr shift))
              (define direction (caddr shift))
              (define val (if (= direction 1) 1 -1))

              (vector-set! deltas start (+ (vector-ref deltas start) val))
              (when (< (+ end 1) n)
                (vector-set! deltas (+ end 1) (- (vector-ref deltas (+ end 1)) val))))
            shifts)

  (define result-chars (make-vector n #\a))
  (define current-shift 0)
  (define char-a-int (char->integer #\a))

  (for ([i (in-range n)])
    (set! current-shift (+ current-shift (vector-ref deltas i)))
    (define original-char (string-ref s i))
    (define original-pos (- (char->integer original-char) char-a-int))
    (define new-pos (modulo (+ original-pos current-shift) 26))
    (define new-char (integer->char (+ char-a-int new-pos)))
    (vector-set! result-chars i new-char))

  (list->string (vector->list result-chars)))