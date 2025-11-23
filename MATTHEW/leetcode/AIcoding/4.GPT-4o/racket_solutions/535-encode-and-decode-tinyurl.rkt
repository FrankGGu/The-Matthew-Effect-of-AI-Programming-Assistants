(define TinyURL
  (let ([url-map (make-hash)]
        [counter 0])
    (define (encode longUrl)
      (set! counter (+ counter 1))
      (define shortUrl (string-append "http://tinyurl.com/" (number->string counter)))
      (hash-set! url-map shortUrl longUrl)
      shortUrl)

    (define (decode shortUrl)
      (hash-ref url-map shortUrl))

    (define (decode-long-url shortUrl)
      (hash-ref url-map shortUrl ""))

    (define (methods)
      (list encode decode))

    methods))