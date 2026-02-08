#lang racket

(define (find-improved-students student_scores)
  (define (improved? scores)
    (let loop ([prev -1] [rest scores])
      (cond
        [(null? rest) #t]
        [(<= (car rest) prev) #f]
        [else (loop (car rest) (cdr rest))])))
  (sort
   (for/list ([student (in-list student_scores)]
              #:when (improved? (cdr student)))
     (car student))
   <))