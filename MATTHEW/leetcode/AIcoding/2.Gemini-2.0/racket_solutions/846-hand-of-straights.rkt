(define (hand-of-straights hand k)
  (if (zero? (modulo (length hand) k))
      (let ([counts (make-hash)])
        (for ([card (in-list hand)])
          (hash-update! counts card (λ (v) (+ v 1)) 1))
        (let loop ([counts counts])
          (cond
            [(hash-empty? counts) #t]
            [else
             (let ([min-card (apply min (hash-keys counts))])
               (let loop2 ([i 0])
                 (cond
                   [(>= i k) (loop (hash-remove-keys counts (λ (key) (<= key (+ min-card k -1)))))]
                   [else
                    (let ([current-card (+ min-card i)])
                      (cond
                        [(not (hash-has-key? counts current-card)) #f]
                        [else
                         (hash-update! counts current-card (λ (v) (- v 1)) 0)
                         (if (zero? (hash-ref counts current-card))
                             (hash-remove! counts current-card))
                         (loop2 (+ i 1))]))]))]))]))
      #f))