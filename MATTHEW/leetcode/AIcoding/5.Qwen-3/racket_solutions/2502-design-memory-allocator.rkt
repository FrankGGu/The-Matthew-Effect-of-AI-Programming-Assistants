#lang racket

(define (make-memory-allocator n)
  (let ((memory (make-vector n #f)))
    (lambda (operation . args)
      (cond ((equal? operation "allocate") 
             (let ((size (car args)) (start (cadr args)))
               (let loop ((i start))
                 (if (>= i (+ start size))
                     #t
                     (if (vector-ref memory i)
                         #f
                         (loop (+ i 1))))))
             (let ((size (car args)) (start (cadr args)))
               (let loop ((i start))
                 (if (>= i (+ start size))
                     #t
                     (begin
                       (vector-set! memory i #t)
                       (loop (+ i 1))))))
             #f)
            ((equal? operation "free")
             (let ((start (car args)))
               (let loop ((i start))
                 (if (>= i (vector-length memory))
                     #t
                     (begin
                       (vector-set! memory i #f)
                       (loop (+ i 1))))))
             #f)
            ((equal? operation "get") 
             (let ((start (car args)))
               (let loop ((i start))
                 (if (>= i (vector-length memory))
                     #f
                     (if (vector-ref memory i)
                         #t
                         (loop (+ i 1))))))
             #f)
            (else #f)))))