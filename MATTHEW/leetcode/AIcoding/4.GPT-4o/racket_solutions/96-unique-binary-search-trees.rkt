(define (numTrees n)
  (define (count-trees start end)
    (if (> start end)
        1
        (foldl (lambda (root acc)
                  (+ acc (* (count-trees start (- root 1))
                             (count-trees (+ root 1) end))))
                0
                (range start (+ end 1)))))
  (count-trees 1 n))