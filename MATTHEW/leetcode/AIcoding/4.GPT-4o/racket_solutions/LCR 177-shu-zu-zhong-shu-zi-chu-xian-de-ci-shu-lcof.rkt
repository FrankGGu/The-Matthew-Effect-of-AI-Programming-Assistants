(define (color-combinations colors)
  (define (helper current remaining)
    (if (null? remaining)
        (list current)
        (apply append
               (map (lambda (color)
                      (helper (cons color current) (remove color remaining)))
                    remaining))))
  (helper '() colors))

(define (get-color-pairs colors)
  (define combinations (color-combinations colors))
  (filter (lambda (pair) (not (= (car pair) (cadr pair))))
          (map (lambda (x) (list (car x) (cadr x))) combinations)))

(define (main)
  (define colors '(1 2 3 4 5))
  (get-color-pairs colors))

(main)