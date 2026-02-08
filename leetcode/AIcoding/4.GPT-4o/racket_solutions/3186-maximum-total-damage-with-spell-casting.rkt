(define (maximum-total-damage spellDamage spellCost mana)
  (define (helper remaining-mana index)
    (if (or (zero? remaining-mana) (>= index (length spellDamage)))
        0
        (let* ((take (if (>= remaining-mana (list-ref spellCost index))
                         (+ (list-ref spellDamage index)
                            (helper (- remaining-mana (list-ref spellCost index)) (+ index 1)))
                         0))
               (skip (helper remaining-mana (+ index 1))))
          (max take skip))))
  (helper mana 0))

(define (maxDamage spellDamage spellCost mana)
  (maximum-total-damage spellDamage spellCost mana))