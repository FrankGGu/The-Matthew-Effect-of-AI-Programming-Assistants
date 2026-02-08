(define (path-encryption path key)
  (let ([n (string-length path)]
        [m (string-length key)])
    (string-map
     (lambda (c i)
       (integer->char (+ (char->integer c) (char->integer (string-ref key (modulo i m))) - 128) ))
     path
     (build-list n identity))))