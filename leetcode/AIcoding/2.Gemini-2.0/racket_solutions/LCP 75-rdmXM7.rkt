(define (minimum-effort heights)
  (define rows (length heights))
  (define cols (length (car heights)))
  (define (valid? r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define (dfs r c effort visited)
    (if (or (hash-has-key? visited (cons r c))
            (> effort (hash-ref visited (cons r c) +inf.0)))
        #f
        (begin
          (hash-set! visited (cons r c) effort)
          (if (and (= r (- rows 1)) (= c (- cols 1)))
              #t
              (let loop ((dr '(-1 1 0 0)) (dc '(0 0 -1 1)))
                (cond
                  ((null? dr) #f)
                  (else
                   (let ((nr (+ r (car dr))) (nc (+ c (car dc))))
                     (if (valid? nr nc)
                         (let ((new-effort (max effort (abs (- (list-ref (list-ref heights r) c) (list-ref (list-ref heights nr) nc))))))
                           (if (dfs nr nc new-effort visited)
                               #t
                               (loop (cdr dr) (cdr dc))))
                         (loop (cdr dr) (cdr dc)))))))))))

  (define (possible? effort)
    (dfs 0 0 effort (make-hash)))

  (define (binary-search low high)
    (cond
      ((> low high) low)
      (else
       (let ((mid (floor (+ low high) 2)))
         (if (possible? mid)
             (binary-search low (- mid 1))
             (binary-search (+ mid 1) high))))))

  (binary-search 0 1000000))