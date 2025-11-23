(define (longest-str-chain words)
  (let* ((word-set (set words))
         (memo (make-hash)))
    (define (chain-length word)
      (cond
        [(hash-has-key? memo word) (hash-ref memo word)]
        [else
         (let loop ((i 0) (max-length 1))
           (if (= i (string-length word))
               (begin
                 (hash-set! memo word max-length)
                 max-length)
               (let* ((new-word (string-remove word i))
                      (new-length (if (set-member? word-set new-word)
                                      (+ 1 (chain-length new-word))
                                      1)))
                 (loop (+ i 1) (max max-length new-length)))))]))
    (foldl (lambda (word acc) (max acc (chain-length word))) 0 words)))

(define (string-remove str index)
  (string-append (substring str 0 index) (substring str (+ index 1) (string-length str))))