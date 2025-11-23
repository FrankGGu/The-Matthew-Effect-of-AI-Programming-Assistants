(define (min-damage health armor damage n arr)
  (define (solve health armor damage n arr idx used-block)
    (cond
      [(>= idx n) (max 0 (- health damage))]
      [else
       (let* ([normal-damage (max 0 (- (list-ref arr idx) armor))]
              [block-damage (max 0 (- (list-ref arr idx) 0))])
         (cond
           [(not used-block)
            (min (+ (solve health armor damage n arr (+ idx 1) used-block) normal-damage)
                 (solve health armor damage n arr (+ idx 1) #t) block-damage)]
           [else
            (+ (solve health armor damage n arr (+ idx 1) used-block) normal-damage)])))]))
  (solve health armor damage n arr 0 #f))

(define (minimum-amount-of-damage-dealt-to-bob health armor damage attacks)
  (min-damage health armor damage (length attacks) attacks))