#lang racket

(define (find-next-greater-index indices-list target-index)
  (let loop ((low 0) (high (sub1 (length indices-list))) (result -1))
    (if (> low high)
        result
        (let* ((mid (+ low (quotient (- high low) 2)))
               (current-val (list-ref indices-list mid)))
          (if (> current-val target-index)
              (loop low (sub1 mid) current-val)
              (loop (add1 mid) high result))))))

(define (num-matching-subsequences s words)
  (define s-len (string-length s))

  (define char-indices (make-hash))
  (for ((i (in-range s-len)))
    (define char (string-ref s i))
    (hash-set! char-indices char (cons i (hash-ref char-indices char '()))))

  (for-each (lambda (char)
              (hash-update! char-indices char reverse))
            (hash-keys char-indices))

  (define (is-subsequence? word)
    (define word-len (string-length word))
    (let loop ((word-idx 0) (current-s-idx -1))
      (if (= word-idx word-len)
          #t
          (let* ((char-to-find (string-ref word word-idx))
                 (indices (hash-ref char-indices char-to-find '())))
            (if (empty? indices)
                #f
                (let ((next-s-pos (find-next-greater-index indices current-s-idx)))
                  (if (= next-s-pos -1)
                      #f
                      (loop (add1 word-idx) next-s-pos))))))))

  (for/sum ((word words))
    (if (is-subsequence? word) 1 0)))