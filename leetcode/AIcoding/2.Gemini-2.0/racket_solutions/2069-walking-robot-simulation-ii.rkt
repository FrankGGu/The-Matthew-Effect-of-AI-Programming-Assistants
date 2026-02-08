(define (robot w h commands)
  (struct robot-state (x y dir))
  (define state (robot-state 0 0 0)) ; 0: East, 1: North, 2: West, 3: South
  (define width w)
  (define height h)
  (define (move-step d)
    (case (robot-state-dir state)
      ((0)
       (let ([new-x (+ (robot-state-x state) d)])
         (cond
           [(< new-x width) (struct-copy robot-state state [x new-x])]
           [else (struct-copy robot-state state [x (- width 1)])]))
       )
      ((1)
       (let ([new-y (+ (robot-state-y state) d)])
         (cond
           [(< new-y height) (struct-copy robot-state state [y new-y])]
           [else (struct-copy robot-state state [y (- height 1)])]))
       )
      ((2)
       (let ([new-x (- (robot-state-x state) d)])
         (cond
           [(>= new-x 0) (struct-copy robot-state state [x new-x])]
           [else (struct-copy robot-state state [x 0])]))
       )
      ((3)
       (let ([new-y (- (robot-state-y state) d)])
         (cond
           [(>= new-y 0) (struct-copy robot-state state [y new-y])]
           [else (struct-copy robot-state state [y 0])]))
       )))

  (define (move d)
    (cond
      [(zero? d) #t]
      [else
       (case (robot-state-dir state)
         ((0)
          (let ([remaining (- width (robot-state-x state) 1)])
            (cond
              [(<= remaining d)
               (set! state (robot-state (- width 1) (robot-state-y state) 1))
               (move (- d remaining))]
              [else
               (set! state (struct-copy robot-state state [x (+ (robot-state-x state) d)]))]))
          )
         ((1)
          (let ([remaining (- height (robot-state-y state) 1)])
            (cond
              [(<= remaining d)
               (set! state (robot-state (- width 1) (- height 1) 2))
               (move (- d remaining))]
              [else
               (set! state (struct-copy robot-state state [y (+ (robot-state-y state) d)]))]))
          )
         ((2)
          (let ([remaining (robot-state-x state)])
            (cond
              [(<= remaining d)
               (set! state (robot-state 0 (- height 1) 3))
               (move (- d remaining))]
              [else
               (set! state (struct-copy robot-state state [x (- (robot-state-x state) d)]))]))
          )
         ((3)
          (let ([remaining (robot-state-y state)])
            (cond
              [(<= remaining d)
               (set! state (robot-state 0 0 0))
               (move (- d remaining))]
              [else
               (set! state (struct-copy robot-state state [y (- (robot-state-y state) d)]))]))
          ))]))

  (for-each move commands)

  (define (get-position)
    (list (robot-state-x state) (robot-state-y state)))

  (define (get-direction)
    (case (robot-state-dir state)
      ((0) "East")
      ((1) "North")
      ((2) "West")
      ((3) "South")))

  (define (create-robot w h commands)
    (letrec ([(robot-object
               (lambda (msg)
                 (case msg
                   (('move dist) (move dist) robot-object)
                   (('getPos) (get-position))
                   (('getDir) (get-direction))
                   (else (error "Unknown message")))))]
      robot-object))

  (create-robot w h commands))

(define (robot* w h)
  (let ([robot (robot w h '())])
    (lambda (msg . args)
      (apply robot (cons msg args)))))

(define (move! robot dist)
  ((robot 'move dist)))

(define (getPos robot)
  ((robot 'getPos)))

(define (getDir robot)
  ((robot 'getDir)))