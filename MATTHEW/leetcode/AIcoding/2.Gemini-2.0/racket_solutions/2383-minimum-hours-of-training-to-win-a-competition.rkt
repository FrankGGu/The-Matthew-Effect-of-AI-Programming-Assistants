(define (min-number-of-hours initial-energy initial-experience energy experience)
  (let* ([n (length energy)]
         [energy-needed
          (foldl (lambda (e acc)
                   (max 0 (+ 1 (- e acc))))
                 initial-energy
                 energy)]
         [experience-needed
          (foldl (lambda (e acc)
                   (if (>= initial-experience e)
                       (+ acc (- e initial-experience) 1)
                       acc))
                 0
                 experience)]
         [total-experience-needed
          (if (> experience-needed 0)
              experience-needed
              0)])
    (if (> energy-needed initial-energy)
        (+ (- energy-needed initial-energy) total-experience-needed)
        total-experience-needed)))