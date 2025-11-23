#lang racket

(define (full-justify words max-width)
  (define (split-words)
    (let loop ((words words) (current '()) (current-length 0) (result '()))
      (cond ((null? words)
             (if (null? current)
                 result
                 (cons (reverse current) result)))
            ((> (+ current-length (length (car words))) max-width)
             (loop (cdr words) (list (car words)) (length (car words)) (cons (reverse current) result)))
            (else
             (loop (cdr words) (cons (car words) current) (+ current-length (length (car words))) result)))))

  (define (justify-line line max-width)
    (let* ((num-words (length line))
           (total-length (apply + (map length line)))
           (spaces (- max-width total-length)))
      (if (= num-words 1)
          (string-append (car line) (make-string spaces #\space))
          (let ((extra-spaces (modulo spaces (- num-words 1))))
            (string-join
             (map (lambda (word)
                    (if (and (not (eqv? word (last line))) (> spaces 0))
                        (string-append word (make-string (quotient spaces (- num-words 1)) #\space))
                        word))
                  line)
             (make-string (quotient spaces (- num-words 1)) #\space)
             #:before-last (make-string (add1 (quotient spaces (- num-words 1))) #\space))))))

  (define (justify-last-line line max-width)
    (string-join line " " #\space max-width))

  (define lines (split-words))
  (append
   (map (lambda (line)
          (if (= (length line) 1)
              (justify-last-line line max-width)
              (justify-line line max-width)))
        (take lines (- (length lines) 1)))
   (if (> (length lines) 0)
       (list (justify-last-line (last lines) max-width))
       '())))

(define (main)
  (define input (read))
  (define max-width (read))
  (for-each (lambda (line) (display line) (newline)) (full-justify input max-width)))

(main)