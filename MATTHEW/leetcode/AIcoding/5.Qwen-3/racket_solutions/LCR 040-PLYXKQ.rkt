#lang racket

(define (max-rectangle matrix)
  (define (largest-rectangle-area heights)
    (define (helper stack i)
      (cond [(null? stack) (if (= i (length heights)) 0 (helper (list i) (+ i 1)))]
            [(>= i (length heights)) 
             (let ([h (list-ref heights (car stack))])
               (if (null? (cdr stack)) 
                   (* h (- (length heights) (car stack)))
                   (* h (- (length heights) (cadr stack) (car stack)))))
             (if (null? (cdr stack)) 0 (helper (cdr stack) i))]
            [else
             (let ([top (car stack)])
               (if (<= (list-ref heights top) (list-ref heights i))
                   (helper (cons i stack) (+ i 1))
                   (let ([h (list-ref heights top)])
                     (let ([area (* h (- i (if (null? (cdr stack)) 0 (cadr stack)))])
                       (if (null? (cdr stack))
                           (helper (list i) i)
                           (helper (cons i (cdr stack)) i)))))]))
    (helper '() 0))

  (if (null? matrix) 0
      (let ([m (length matrix)]
            [n (length (car matrix))])
        (let loop ([row 0] [heights (make-list n 0)] [max-area 0])
          (if (= row m) max-area
              (begin
                (for ([i (in-range n)])
                  (set! heights (replace-at heights i (if (= (list-ref (list-ref matrix row) i) #\1)
                                                          (+ (list-ref heights i) 1)
                                                          0))))
                (let ([current-area (largest-rectangle-area heights)])
                  (loop (+ row 1) heights (max max-area current-area))))))))

(define (replace-at lst index val)
  (if (null? lst) '()
      (if (= index 0) (cons val (cdr lst))
          (cons (car lst) (replace-at (cdr lst) (- index 1) val)))))

(define (main)
  (define input (read))
  (display (max-rectangle input)))

(main)