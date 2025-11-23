(define tiny-to-long (make-hash))
(define long-to-tiny (make-hash))
(define counter (box 0))

(define (encode longUrl)
  (if (hash-has-key? long-to-tiny longUrl)
      (hash-ref long-to-tiny longUrl)
      (let* ([i (unbox counter)]
             [tinyUrl (string-append "http://tinyurl.com/" (number->string i))])
        (hash-set! tiny-to-long tinyUrl longUrl)
        (hash-set! long-to-tiny longUrl tinyUrl)
        (set-box! counter (+ i 1))
        tinyUrl)))

(define (decode tinyUrl)
  (if (hash-has-key? tiny-to-long tinyUrl)
      (hash-ref tiny-to-long tinyUrl)
      ""))