(define (replace-digits s)
  (string-map
   (lambda (c i)
     (if (char-numeric? c)
         (integer->char (+ (char->integer (string-ref s (- i 1))) (string->number (string (list c)))))
         c))
   s
   (range 0 (string-length s))))