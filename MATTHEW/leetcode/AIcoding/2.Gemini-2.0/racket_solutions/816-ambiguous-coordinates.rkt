(define (ambiguous-coordinates s)
  (define (valid-num? num)
    (cond
      [(empty? num) #f]
      [(and (= (string-length num) 1) (string=? (substring num 0 1) "0")) #t]
      [(and (> (string-length num) 1) (string=? (substring num 0 1) "0") (not (string=? (substring num (sub1 (string-length num)) (string-length num)) "0"))) #f]
      [(and (> (string-length num) 1) (string=? (substring num (sub1 (string-length num)) (string-length num)) "0")) #t]
      [else #t]))

  (define (possible-nums num)
    (cond
      [(empty? num) '()]
      [else
       (let loop ([i 1] [acc '()])
         (cond
           [(> i (string-length num)) acc]
           [else
            (let* ([first-part (substring num 0 i)]
                   [second-part (substring num i (string-length num))]
                   [combined (string-append first-part (if (empty? second-part) "" ".") second-part)]
                   [valid (valid-num? combined)])
              (loop (add1 i) (if valid (cons combined acc) acc))))])]))

  (define (cartesian-product xs ys)
    (foldr (lambda (x acc) (append (map (lambda (y) (list x y)) ys) acc)) '() xs))

  (let* ([trimmed (substring s 1 (- (string-length s) 1))]
         [n (string-length trimmed)]
         [result '()])
    (for ([i (in-range 1 n)])
      (let* ([x-str (substring trimmed 0 i)]
             [y-str (substring trimmed i n)]
             [x-nums (possible-nums x-str)]
             [y-nums (possible-nums y-str)])
        (if (and (not (empty? x-nums)) (not (empty? y-nums)))
            (let ([pairs (cartesian-product x-nums y-nums)])
              (for ([pair (in-list pairs)])
                (set! result (cons (string-append "(" (car pair) ", " (cadr pair) ")") result)))))))
    result))