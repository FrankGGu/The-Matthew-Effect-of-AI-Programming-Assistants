(define/contract (dest-city paths)
  (-> (listof (listof string?)) string?)
  (let* ([start-cities (map car paths)]
         [end-cities (map cadr paths)]
         [dest (for/first ([city end-cities]
                           #:unless (member city start-cities))
                 city)])
    dest))