(define (factorial n)
  (if (<= n 1)
      1
      (* n (factorial (- n 1)))))

(define (mod-pow base exp mod)
  (let loop ((b base) (e exp) (result 1))
    (cond
      [(zero? e) result]
      [(odd? e) (loop (modulo (* b b) mod) (quotient e 2) (modulo (* result b) mod))]
      [else (loop (modulo (* b b) mod) (quotient e 2) result)])))

(define (mod-inverse a mod)
  (mod-pow a (- mod 2) mod))

(define (minimum-steps s)
  (let* ((n (string-length s))
         (mod 1000000007)
         (freq (make-hash))
         (total 0))
    (for ([c (in-string s)])
      (hash-update! freq c (lambda (v) (+ v 1)) 1)
      (set! total (+ total 1)))
    (let loop ((i 0) (result 0))
      (if (= i (- n 1))
          result
          (let* ((smaller-count 0)
                 (current-char (string-ref s i)))
            (for ([j (in-range (+ i 1) n)])
              (when (< (string-ref s j) current-char)
                (set! smaller-count (+ smaller-count 1))))
            (let* ((num (factorial (- total 1)))
                   (den (let ((den 1))
                          (for ((k (in-hash-keys freq)))
                            (set! den (modulo (* den (factorial (hash-ref freq k))) mod)))
                          den))
                   (term (modulo (* num (mod-inverse den mod)) mod))
                   (contribution (modulo (* smaller-count term) mod)))
              (set! result (modulo (+ result contribution) mod))
              (hash-update! freq current-char (lambda (v) (- v 1)))
              (when (= (hash-ref freq current-char) 0)
                (hash-remove! freq current-char))
              (set! total (- total 1))
              (loop (+ i 1) result)))))))