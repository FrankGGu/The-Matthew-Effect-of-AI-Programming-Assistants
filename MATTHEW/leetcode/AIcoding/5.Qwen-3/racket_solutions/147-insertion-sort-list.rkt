(define (insertion-sort-list head)
  (if (or (null? head) (null? (cdr head)))
      head
      (let ((sorted (insertion-sort-list (cdr head))))
        (let loop ((current head) (prev #f) (sorted sorted))
          (if (or (null? current) (<= (car current) (car sorted)))
              (if prev
                  (begin (set-cdr! prev (cons (car current) (cdr current)))
                         (set-cdr! current sorted)
                         sorted)
                  (begin (set-cdr! current sorted)
                         current))
              (loop (cdr current) current sorted))))))

(define (make-list . args)
  (if (null? args)
      '()
      (cons (car args) (apply make-list (cdr args))))

(define (print-list head)
  (if (null? head)
      (void)
      (begin (display (car head)) (display " ") (print-list (cdr head))))

(define (main)
  (define lst (make-list 4 2 1 3))
  (define sorted (insertion-sort-list lst))
  (print-list sorted))

(main)