(define (make-encoder)
  (let ((url-map (make-hash))
    (lambda (longUrl)
      (let ((shortUrl (string-append "http://tinyurl.com/" (number->string (equal-hash-code longUrl)))))
        (hash-set! url-map shortUrl longUrl)
        shortUrl))))

(define encode (make-encoder))

(define (decode shortUrl)
  (hash-ref url-map shortUrl))

(define url-map (make-hash))