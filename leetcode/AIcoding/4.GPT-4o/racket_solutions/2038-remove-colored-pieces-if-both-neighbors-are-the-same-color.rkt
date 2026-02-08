(define (remove-colored-pieces colors)
  (define (can-remove? colors i)
    (and (> i 0) (< i (length colors))
         (= (list-ref colors (- i 1)) (list-ref colors i))
         (= (list-ref colors (+ i 1)) (list-ref colors i))))

  (define (dfs colors)
    (if (null? colors)
        #t
        (for/or ([i (in-range (length colors))])
          (when (can-remove? colors i)
            (dfs (append (take colors i) (drop colors (+ i 1))))))))

  (dfs colors))