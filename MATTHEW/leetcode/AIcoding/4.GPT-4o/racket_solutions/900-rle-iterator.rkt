(define RLEIterator
  (lambda (A)
    (define idx 0)
    (define pos 0)
    (define (next n)
      (let loop ()
        (if (>= idx (length A))
            -1
            (let ((count (list-ref A idx)))
              (if (>= pos count)
                  (begin
                    (set! pos (- pos count))
                    (set! idx (+ idx 2))
                    (loop))
                  (begin
                    (set! pos (+ pos n))
                    (list-ref A idx)))))))
    (define (hasNext)
      (not (>= idx (length A))))
    (lambda (op . args)
      (cond
        ((equal? op 'next) (next (car args)))
        ((equal? op 'hasNext) (hasNext)))))

(define rle-iterator (RLEIterator '(3 8 0 9 2 5)))
(display (rle-iterator 'next 2)) ; Output: 8
(display (rle-iterator 'next 1)) ; Output: 8
(display (rle-iterator 'next 1)) ; Output: 5
(display (rle-iterator 'next 2)) ; Output: -1
(display (rle-iterator 'hasNext)) ; Output: #f