(define (substring-hash s power modulo k hashValue)
  (define n (string-length s))
  (define (char->val c) (- (char->integer c) 97))

  (let loop ((i (- n k)) (curr-hash 0) (power-pk 1) (result ""))
    (cond
      ((< i 0) result)
      (else
       (let* ((c (string-ref s i))
              (new-hash (modulo (+ (* (char->val c) power-pk) curr-hash) modulo))
              (new-power-pk (modulo (* power-pk power) modulo)))
              (new-result (if (= new-hash hashValue) (substring s i (+ i k)) result)))
         (loop (- i 1) new-hash new-power-pk new-result))))))