(define (maximum-population-year logs)
  (let* ([pop-changes (make-hash)]
         [min-birth-year 2051] ; Initialize with a value higher than any possible birth year (e.g., 2050 + 1)
         [max-death-year 1949]) ; Initialize with a value lower than any possible death year (e.g., 1950 - 1)

    ; First pass: Populate pop-changes hash table and find the overall min/max years
    (for-each (lambda (log)
                (let ([birth (car log)]
                      [death (cadr log)])
                  ; Increment population at birth year
                  (hash-set! pop-changes birth (+ (hash-ref pop-changes birth 0) 1))
                  ; Decrement population at death year (person is not alive in death year)
                  (hash-set! pop-changes death (+ (hash-ref pop-changes death 0) -1))

                  ; Update min/max years to define the iteration range
                  (set! min-birth-year (min min-birth-year birth))
                  (set! max-death-year (max max-death-year death))))
              logs)

    ; Second pass: Calculate cumulative population year by year and find the maximum
    (let loop ([year min-birth-year]
               [current-population 0]
               [max-population 0]
               [earliest-max-year min-birth-year]) ; Initialize with the first possible year
      ; Iterate up to max-death-year - 1, as population is considered for year x where birth <= x < death
      (if (>= year max-death-year)
          earliest-max-year
          (let* ([change (hash-ref pop-changes year 0)]
                 [new-population (+ current-population change)])
            (if (> new-population max-population)
                ; New maximum population found, update max-population and earliest-max-year
                (loop (+ year 1) new-population new-population year)
                ; Population is not greater, keep existing max-population and earliest-max-year
                (loop (+ year 1) new-population max-population earliest-max-year)))))))