(define (robot-sim commands obstacles)
  (define obstacle-map
    (for/fold ([m (make-hash)])
              ([obs obstacles])
      (let* ([ox (list-ref obs 0)]
             [oy (list-ref obs 1)])
        (hash-set! m ox (set-add (hash-ref m ox (set)) oy)))
      m))

  (define x 0)
  (define y 0)
  (define dir 0) ; 0: North, 1: East, 2: South, 3: West
  (define max-dist-sq 0)

  (define (update-max-dist-sq!)
    (set! max-dist-sq (max max-dist-sq (+ (* x x) (* y y)))))

  (define directions (list (list 0 1) (list 1 0) (list 0 -1) (list -1 0))) ; (dx dy) for N, E, S, W

  (update-max-dist-sq!) ; Initial position (0,0)

  (for ([cmd commands])
    (cond
      [(= cmd -2) ; Turn left
       (set! dir (modulo (+ dir 3) 4))]
      [(= cmd -1) ; Turn right
       (set! dir (modulo (+ dir 1) 4))]
      [else ; Move forward cmd units
       (let* ([current-direction-vec (list-ref directions dir)]
              [current-dx (list-ref current-direction-vec 0)]
              [current-dy (list-ref current-direction-vec 1)])
         (for ([_ (in-range cmd)])
           (let* ([next-x (+ x current-dx)]
                  [next-y (+ y current-dy)])
             (if (set-contains? (hash-ref obstacle-map next-x (set)) next-y)
                 ; Obstacle found, stop moving for this command
                 (break)
                 ; No obstacle, move to next position
                 (begin
                   (set! x next-x)
                   (set! y next-y)
                   (update-max-dist-sq!))))))]))
  max-dist-sq)