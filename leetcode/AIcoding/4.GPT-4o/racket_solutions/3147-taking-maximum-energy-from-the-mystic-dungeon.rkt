(define (maxEnergy d k)
  (define (dp i energy)
    (if (>= i (length d))
        energy
        (let ((take (if (>= energy (list-ref d i))
                        (dp (+ i 1) (- energy (list-ref d i)))
                        -1))
              (skip (dp (+ i 1) energy)))
          (max take skip))))
  (dp 0 k))

(define (maxEnergyFromMysticDungeon d k)
  (maxEnergy d k))