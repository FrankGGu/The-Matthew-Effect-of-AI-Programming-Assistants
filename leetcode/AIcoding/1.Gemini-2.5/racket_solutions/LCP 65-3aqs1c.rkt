(define (comfortable-humidity-count humidities min-comfort max-comfort)
  (length (filter (lambda (h)
                    (and (>= h min-comfort) (<= h max-comfort)))
                  humidities)))