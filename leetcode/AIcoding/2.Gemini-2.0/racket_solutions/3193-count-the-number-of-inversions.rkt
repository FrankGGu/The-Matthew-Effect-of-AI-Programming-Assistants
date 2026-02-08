(define (count-inversions lst)
  (define (merge-and-count left right)
    (let loop ([left left] [right right] [merged '()] [count 0])
      (cond
        [(empty? left) (values (append (reverse merged) right) count)]
        [(empty? right) (values (append (reverse merged) left) count)]
        [(<= (car left) (car right)) (loop (cdr left) right (cons (car left) merged) count)]
        [else (loop left (cdr right) (cons (car right) merged) (+ count (length left)))])))

  (define (sort-and-count lst)
    (cond
      [(empty? lst) (values '() 0)]
      [(empty? (cdr lst)) (values lst 0)]
      [else
       (let* ([mid (floor (/ (length lst) 2))]
              [left (take lst mid)]
              [right (drop lst mid)]
              (values left-sorted left-count) (sort-and-count left)
              (values right-sorted right-count) (sort-and-count right)
              (values merged-sorted merge-count) (merge-and-count left-sorted right-sorted))
         (values merged-sorted (+ left-count right-count merge-count)))]))

  (cdr (sort-and-count lst)))