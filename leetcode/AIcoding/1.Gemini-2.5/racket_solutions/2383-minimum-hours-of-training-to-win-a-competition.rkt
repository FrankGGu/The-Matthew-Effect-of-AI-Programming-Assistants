(define (min-training-hours initial-energy initial-experience energy experience)
  (let loop ((current-energy initial-energy)
             (current-experience initial-experience)
             (total-training 0)
             (energy-list energy)
             (experience-list experience))
    (if (empty? energy-list)
        total-training
        (let* ((opponent-energy (car energy-list))
               (opponent-experience (car experience-list))

               (energy-training-needed (if (<= current-energy opponent-energy)
                                           (- opponent-energy current-energy -1)
                                           0))
               (new-total-training (+ total-training energy-training-needed))
               (energy-after-training (+ current-energy energy-training-needed))
               (energy-after-fight (- energy-after-training opponent-energy))

               (experience-training-needed (if (<= current-experience opponent-experience)
                                               (- opponent-experience current-experience -1)
                                               0))
               (final-total-training (+ new-total-training experience-training-needed))
               (experience-after-training (+ current-experience experience-training-needed))
               (experience-after-fight (+ experience-after-training opponent-experience)))

          (loop energy-after-fight
                experience-after-fight
                final-total-training
                (cdr energy-list)
                (cdr experience-list))))))