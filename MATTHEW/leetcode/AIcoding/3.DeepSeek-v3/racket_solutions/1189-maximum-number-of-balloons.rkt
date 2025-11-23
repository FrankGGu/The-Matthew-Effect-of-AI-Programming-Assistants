(define (max-number-of-balloons text)
  (let* ([count-b (count (lambda (c) (char=? c #\b)) text)]
         [count-a (count (lambda (c) (char=? c #\a)) text)]
         [count-l (/ (count (lambda (c) (char=? c #\l)) text) 2)]
         [count-o (/ (count (lambda (c) (char=? c #\o)) text) 2)]
         [count-n (count (lambda (c) (char=? c #\n)) text])
    (floor (apply min (list count-b count-a count-l count-o count-n)))))