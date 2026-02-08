(define (matrixScore A)
  (define (flip-row row)
    (map (lambda (x) (if (= x 0) 1 0)) row))

  (define (flip-col col)
    (map (lambda (row) (if (= (list-ref row col) 0) 1 0)) A))

  (define (score-column col)
    (apply + (map (lambda (row) (list-ref row col)) A)))

  (define (max-score)
    (let loop ((col 0) (total 0))
      (if (< col (length (car A)))
          (let* ((score (score-column col))
                 (new-total (+ total (max score (- (length A) score)))))
            (loop (+ col 1) new-total))
          total)))

  (define (flip-first-row)
    (set! A (cons (map (lambda (x) (if (= x 0) 1 0)) (car A)) (cdr A)))
    (set! A (map (lambda (row) (cons (list-ref (car A) 0) (cdr row))) A)))
    (max-score))

  (flip-first-row))

(define (flip-and-score A)
  (matrixScore A))