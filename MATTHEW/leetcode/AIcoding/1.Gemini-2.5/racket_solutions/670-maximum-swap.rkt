(define (maximum-swap num)
  (define s (number->string num))
  (define n (string-length s))
  (define char-vec (list->vector (string->list s)))

  (define (vec->num v)
    (string->number (list->string (vector->list v))))

  (let loop ([i 0])
    (cond
      [(= i n)
       num]
      [else
       (define current-char (vector-ref char-vec i))
       (define current-digit (char->integer current-char))

       (define max-digit-val -1)
       (define max-digit-idx -1)

       (for ([j (in-range (+ i 1) n)])
         (define right-char (vector-ref char-vec j))
         (define right-digit (char->integer right-char))
         (when (>= right-digit max-digit-val)
           (set! max-digit-val right-digit)
           (set! max-digit-idx j)))

       (if (> max-digit-val current-digit)
           (begin
             (define temp (vector-ref char-vec i))
             (vector-set! char-vec i (vector-ref char-vec max-digit-idx))
             (vector-set! char-vec max-digit-idx temp)
             (vec->num char-vec))
           (loop (+ i 1)))])))