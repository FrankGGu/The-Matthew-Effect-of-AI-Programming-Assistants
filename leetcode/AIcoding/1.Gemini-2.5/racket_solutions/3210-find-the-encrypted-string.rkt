(define (get-encrypted-string s k)
  (list->string
   (for/list ([i (in-range (string-length s))])
     (if (= (modulo i k) 0)
         (string-ref s i)
         #\*))))