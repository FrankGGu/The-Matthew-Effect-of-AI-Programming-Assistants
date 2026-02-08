(define *long-to-short* (make-hash))
(define *short-to-long* (make-hash))
(define *counter* 0)
(define *base-url* "http://tinyurl.com/")

(define (encode longUrl)
  (let ((existing-short (hash-ref *long-to-short* longUrl #f)))
    (if existing-short
        existing-short
        (begin
          (set! *counter* (+ *counter* 1))
          (let* ((short-code (number->string *counter*))
                 (shortUrl (string-append *base-url* short-code)))
            (hash-set! *long-to-short* longUrl shortUrl)
            (hash-set! *short-to-long* shortUrl longUrl)
            shortUrl)))))

(define (decode shortUrl)
  (hash-ref *short-to-long* shortUrl #f))