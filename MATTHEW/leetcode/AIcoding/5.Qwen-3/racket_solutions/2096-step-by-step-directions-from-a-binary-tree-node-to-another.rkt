#lang racket

(define (get-directions root start-value end-value)
  (define (find-path root target path)
    (cond [(not root) #f]
          [(= (car root) target) (reverse path)]
          [else
           (let ([left (find-path (cadr root) target (cons 'L path))])
             (if left
                 left
                 (find-path (caddr root) target (cons 'R path))))]))

  (define (build-path path)
    (map (lambda (d) (if (eq? d 'L) "Left" "Right")) path))

  (define start-path (find-path root start-value '()))
  (define end-path (find-path root end-value '()))

  (define (common-prefix a b)
    (let loop ([a a] [b b] [i 0])
      (if (or (null? a) (null? b) (not (equal? (list-ref a i) (list-ref b i))))
          i
          (loop a b (+ i 1)))))

  (define prefix-length (common-prefix start-path end-path))

  (define start-suffix (take-right start-path (- (length start-path) prefix-length)))
  (define end-suffix (take-right end-path (- (length end-path) prefix-length)))

  (string-join (append (map (lambda (d) "U") start-suffix) (build-path end-suffix)) ""))

(define (make-tree lst)
  (define (helper idx)
    (if (>= idx (length lst))
        #f
        (if (eqv? (list-ref lst idx) 'null)
            #f
            (list (list-ref lst idx)
                  (helper (+ idx 1))
                  (helper (+ idx 2))))))
  (helper 0))

(define (main)
  (define input (read))
  (define start-value (read))
  (define end-value (read))
  (define root (make-tree input))
  (displayln (get-directions root start-value end-value)))

(main)