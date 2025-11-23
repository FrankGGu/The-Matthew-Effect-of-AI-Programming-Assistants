(define (method-chaining)
  (let ((obj (make-hash)))
    (set! obj (hash-set obj 'value 0))
    (define (set-value v)
      (hash-set! obj 'value v)
      obj)
    (define (get-value)
      (hash-ref obj 'value))
    (define (add-value v)
      (hash-set! obj 'value (+ (hash-ref obj 'value) v))
      obj)
    (define (multiply-value v)
      (hash-set! obj 'value (* (hash-ref obj 'value) v))
      obj)
    (lambda (method . args)
      (cond
        [(eq? method 'set-value) (apply set-value args)]
        [(eq? method 'get-value) (get-value)]
        [(eq? method 'add-value) (apply add-value args)]
        [(eq? method 'multiply-value) (apply multiply-value args)]))))