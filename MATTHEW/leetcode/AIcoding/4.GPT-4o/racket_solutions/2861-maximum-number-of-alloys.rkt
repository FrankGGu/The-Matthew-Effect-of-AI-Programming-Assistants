(define (maxAlloys recipes)
  (define (canProduce n)
    (for/all ([recipe recipes])
      (let ([a (car recipe)]
            [b (cadr recipe)]
            [c (caddr recipe)])
        (>= (/ n a) (+ (/ n b) (/ n c))))))

  (define (binarySearch low high)
    (if (>= low high)
        low
        (let ([mid (quotient (+ low high) 2)])
          (if (canProduce mid)
              (binarySearch mid high)
              (binarySearch low mid)))))

  (binarySearch 0 (max (map (lambda (recipe) (apply + recipe)) recipes))))
)