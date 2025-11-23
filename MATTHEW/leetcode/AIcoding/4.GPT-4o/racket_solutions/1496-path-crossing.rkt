(define (isPathCrossing path)
  (define (helper pos visited)
    (if (member pos visited)
        #t
        (let ((new-visited (cons pos visited)))
          (or (helper (cons (+ (car pos) 1) (cdr pos)) new-visited)
              (helper (cons (- (car pos) 1) (cdr pos)) new-visited)
              (helper (cons (car pos) (+ (cdr pos) 1)) new-visited)
              (helper (cons (car pos) (- (cdr pos) 1)) new-visited)))))
  (helper '(0 0) '((0 0))))

(define (isPathCrossing path)
  (define visited (make-hash))
  (define current (list 0 0))
  (hash-set! visited (list-ref current 0) (list-ref current 1))
  (for ([move path])
    (cond
      [(equal? move "N") (set! current (list (list-ref current 0) (+ (list-ref current 1) 1)))]
      [(equal? move "S") (set! current (list (list-ref current 0) (- (list-ref current 1) 1)))]
      [(equal? move "E") (set! current (list (+ (list-ref current 0) 1) (list-ref current 1)))]
      [(equal? move "W") (set! current (list (- (list-ref current 0) 1) (list-ref current 1)))]))
    (if (hash-has-key? visited (list-ref current 0) (list-ref current 1))
        (begin
          (display #t)
          (return)))
    (hash-set! visited (list-ref current 0) (list-ref current 1)))
  (display #f))