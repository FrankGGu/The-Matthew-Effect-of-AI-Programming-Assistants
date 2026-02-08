(define (last-substring s)
  (define (find-max-char-index s)
    (let loop ((i 0) (max-char #\0) (max-index -1))
      (cond
        [(= i (string-length s)) max-index]
        [(> (string-ref s i) max-char)
         (loop (+ i 1) (string-ref s i) i)]
        [(= (string-ref s i) max-char)
         (loop (+ i 1) max-char i)]
        [else (loop (+ i 1) max-char max-index)])))

  (define max-index (find-max-char-index s))
  (define max-char (string-ref s max-index))

  (define (find-last-substring s start max-char)
    (let loop ((i start) (last-index start))
      (if (>= i (string-length s))
          last-index
          (if (char=? (string-ref s i) max-char)
              (loop (+ i 1) i)
              (loop (+ i 1) last-index)))))

  (define last-start (find-last-substring s max-index max-char))
  (substring s last-start (string-length s)))

(last-substring "abab") ; Call the function with the example