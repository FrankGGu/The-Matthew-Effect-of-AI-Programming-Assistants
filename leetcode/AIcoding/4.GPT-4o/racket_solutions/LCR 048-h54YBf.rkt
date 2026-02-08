(define TreeNode
  (lambda (val left right)
    (list 'TreeNode val left right)))

(define (serialize root)
  (define (helper node)
    (if (null? node)
        "#"
        (string-append (number->string (cadr node)) ","
                       (helper (caddr node)) ","
                       (helper (cadddr node)))))
  (helper root))

(define (deserialize data)
  (define tokens (string-split data ","))
  (define (helper)
    (if (equal? (car tokens) "#")
        (begin (set-cdr! tokens (cdr tokens)) '())
        (let ((val (string->number (car tokens))))
          (set-cdr! tokens (cdr tokens))
          (TreeNode val (helper) (helper)))))
  (helper))

(define (string-split s delimiter)
  (let loop ((start 0) (result '()))
    (let ((pos (string-index s delimiter start)))
      (if pos
          (loop (+ pos (string-length delimiter)) (cons (substring s start pos) result))
          (reverse (cons (substring s start) result))))))

(define (number->string n)
  (number->string n))

(define (string->number s)
  (string->number s))