#lang racket

(define (encrypt-keys keys)
  (for/hash ([key keys])
    (values (string-ref key 0) (substring key 1))))

(define (encrypt word keys)
  (define key-hash (encrypt-keys keys))
  (list->string
   (for/list ([c word])
     (define next (hash-ref key-hash c #f))
     (if next (string-ref next 0) c))))

(define (decrypt-keys keys)
  (for/hash ([key keys])
    (values (substring key 1) (string-ref key 0))))

(define (decrypt word keys)
  (define key-hash (decrypt-keys keys))
  (list->string
   (for/list ([c word])
     (define prev (hash-ref key-hash (string c) #f))
     (if prev prev c))))

(define (encrypt-and-decrypt-strings commands words)
  (define key-hash (make-hash))
  (define result '())
  (for ([cmd commands] [word words])
    (case cmd
      [("encrypt")
       (set! result (cons (encrypt word (hash-keys key-hash)) result))]
      [("decrypt")
       (set! result (cons (decrypt word (hash-keys key-hash)) result)]
      [("add")
       (for ([k word])
         (hash-set! key-hash (string-ref k 0) (substring k 1)))]))
  (reverse result))