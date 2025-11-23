(require srfi/13)

(define (repeated-substring-pattern s)
  (let* ((n (string-length s)))
    (if (zero? n)
        #f
        (string-contains? (substring (string-append s s) 1 (sub1 (* 2 n))) s))))