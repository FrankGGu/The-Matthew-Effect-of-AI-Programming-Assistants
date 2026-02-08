(define (my-linked-list)
  (let ([head '()])
    (define (get index)
      (let loop ([curr head] [i 0])
        (cond
          [(null? curr) -1]
          [(= i index) (car curr)]
          [else (loop (cdr curr) (+ i 1))])))
    (define (add-at-head val)
      (set! head (cons val head)))
    (define (add-at-tail val)
      (let loop ([curr head])
        (cond
          [(null? curr) (set! head (list val))]
          [(null? (cdr curr)) (set-cdr! curr (list val))]
          [else (loop (cdr curr))])))
    (define (add-at-index index val)
      (cond
        [(= index 0) (add-at-head val)]
        [else
         (let loop ([prev '()] [curr head] [i 0])
           (cond
             [(null? curr) #f]
             [(= i index)
              (cond
                [(null? prev) (set! head (cons val head))]
                [else (set-cdr! prev (cons val curr))])]
             [else (loop curr (cdr curr) (+ i 1))]))]))
    (define (delete-at-index index)
      (cond
        [(= index 0)
         (cond
           [(null? head) #f]
           [else (set! head (cdr head))])]
        [else
         (let loop ([prev '()] [curr head] [i 0])
           (cond
             [(null? curr) #f]
             [(= i index)
              (cond
                [(null? prev) (set! head (cdr curr))]
                [else (set-cdr! prev (cdr curr))])]
             [else (loop curr (cdr curr) (+ i 1))]))]))
    (list get add-at-head add-at-tail add-at-index delete-at-index)))

(define (get linked-list index)
  ((list-ref linked-list 0) index))

(define (add-at-head linked-list val)
  ((list-ref linked-list 1) val))

(define (add-at-tail linked-list val)
  ((list-ref linked-list 2) val))

(define (add-at-index linked-list index val)
  ((list-ref linked-list 3) index val))

(define (delete-at-index linked-list index)
  ((list-ref linked-list 4) index))