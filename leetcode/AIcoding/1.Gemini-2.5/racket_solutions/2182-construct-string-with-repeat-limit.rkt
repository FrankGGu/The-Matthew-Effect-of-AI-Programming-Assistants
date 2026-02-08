(define (construct-string-with-repeat-limit s repeatLimit)
  (define freq (make-vector 26 0))
  (define a-int (char->integer #\a))

  ;; Populate frequency vector
  (for-each
   (lambda (c)
     (define idx (- (char->integer c) a-int))
     (vector-set! freq idx (+ (vector-ref freq idx) 1)))
   (string->list s))

  (define result-chars '())
  (define i 25) ; Current character index ('z' down to 'a')

  (while (>= i 0)
    ;; Try to append current character 'i'
    (if (> (vector-ref freq i) 0)
        (begin
          ;; Append 'i' up to repeatLimit times
          (define num-to-append (min (vector-ref freq i) repeatLimit))
          (for ([_ (in-range num-to-append)])
            (set! result-chars (cons (integer->char (+ a-int i)) result-chars)))
          (vector-set! freq i (- (vector-ref freq i) num-to-append))

          ;; If we still have 'i' left after appending repeatLimit times
          (if (> (vector-ref freq i) 0)
              (begin
                ;; Find the next largest available character 'j' (j < i)
                (define j (- i 1))
                (define found-next-char-idx -1)
                (while (and (>= j 0) (= found-next-char-idx -1))
                  (when (> (vector-ref freq j) 0)
                    (set! found-next-char-idx j))
                  (set! j (- j 1)))

                ;; If a smaller character 'j' was found
                (if (>= found-next-char-idx 0)
                    (begin
                      ;; Append it once to break the sequence
                      (set! result-chars (cons (integer->char (+ a-int found-next-char-idx)) result-chars))
                      (vector-set! freq found-next-char-idx (- (vector-ref freq found-next-char-idx) 1))
                      ;; After placing a smaller char, we can try to place 'i' again.
                      ;; So, 'i' remains the same for the next iteration of the outer while loop.
                      )
                    ;; If no smaller character was found, we cannot use 'i' anymore.
                    ;; We must move to the next largest character.
                    (set! i (- i 1))))
              ;; Else (if (vector-ref freq i) is 0 after appending, or we didn't hit repeatLimit)
              ;; We have exhausted character 'i' or used it sufficiently. Move to the next char.
              (set! i (- i 1))))
        ;; Else (if (vector-ref freq i) was 0 initially)
        ;; Character 'i' is not available. Move to the next char.
        (set! i (- i 1))))

  (list->string (reverse result-chars)))