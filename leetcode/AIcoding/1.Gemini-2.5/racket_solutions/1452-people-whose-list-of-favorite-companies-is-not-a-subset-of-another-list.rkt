#lang racket

(require data/set)

(define (people-whose-list-of-favorite-companies-is-not-a-subset-of-another-list favoriteCompanies)
  (let* ([n (length favoriteCompanies)]
         [company-sets (map list->set favoriteCompanies)])

    (define (is-subset-of-any-other? i)
      (let ([current-set (list-ref company-sets i)])
        (let loop ([j 0])
          (cond
            [(>= j n) #f] ; Not a subset of any other
            [(= i j) (loop (+ j 1))] ; Skip checking against itself
            [(set-subset? current-set (list-ref company-sets j)) #t] ; Is a subset of another
            [else (loop (+ j 1))]))))

    (for/list ([i (in-range n)]
               #:when (not (is-subset-of-any-other? i)))
      i)))