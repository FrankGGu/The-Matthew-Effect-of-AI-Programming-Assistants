#lang racket

(define (robot-collisions positions healths directions)
  ;; Combine robot information: (list original-index position health direction-char)
  ;; original-index is needed for final sorting.
  (define initial-robots
    (map (lambda (idx pos health dir-char)
           (list idx pos health dir-char))
         (range (length positions))
         positions
         healths
         (string->list directions)))

  ;; Sort robots by their physical position
  (define sorted-robots
    (sort initial-robots (lambda (r1 r2) (< (list-ref r1 1) (list-ref r2 1)))))

  ;; Helper function to process a single robot against the current stack.
  ;; The stack contains only 'R' moving robots that haven't collided yet.
  ;; Returns (list new-stack maybe-surviving-l-robot)
  ;;   - new-stack: The updated stack after potential collisions.
  ;;   - maybe-surviving-l-robot: The L robot if it survived all collisions, #f otherwise.
  (define (process-robot-with-stack current-robot stack)
    (match current-robot
      ((list orig-idx pos health #\R)
       ;; If the robot moves 'R', push it onto the stack. It will collide with 'L' robots later.
       (list (cons current-robot stack) #f))
      ((list orig-idx pos health #\L)
       ;; If the robot moves 'L', it attempts to collide with 'R' robots on the stack.
       (let loop ((current-l-robot current-robot)
                  (current-stack stack))
         (if (empty? current-stack)
             ;; If the stack is empty, this 'L' robot survives all collisions to its right.
             (list current-stack current-l-robot)
             (match (car current-stack)
               ((list r-orig-idx r-pos r-health #\R)
                (cond
                  [(= r-health (list-ref current-l-robot 2))
                   ;; Healths are equal, both robots are destroyed.
                   (list (cdr current-stack) #f)]
                  [(> r-health (list-ref current-l-robot 2))
                   ;; The 'R' robot wins, its health decreases by 1. The 'L' robot is destroyed.
                   (list (cons (list r-orig-idx r-pos (- r-health 1) #\R) (cdr current-stack)) #f)]
                  [(< r-health (list-ref current-l-robot 2))
                   ;; The 'L' robot wins, its health decreases by 1. The 'R' robot is destroyed.
                   ;; The 'L' robot continues to collide with the next 'R' robot on the stack.
                   (loop (list (list-ref current-l-robot 0)
                               (list-ref current-l-robot 1)
                               (- (list-ref current-l-robot 2) 1)
                               #\L)
                         (cdr current-stack))]))
               ;; This case should ideally not be reached if the stack only contains 'R' robots.
               ;; If it somehow contains a non-'R' robot, the 'L' robot would survive past it.
               (_ ; Fallback, should not happen with correct stack management
                (list current-stack current-l-robot)))))))

  ;; Process all robots in sorted order using foldl.
  ;; The accumulator `acc` is a list: (list stack surviving-l-robots-list).
  (define final-state
    (foldl (lambda (robot acc)
             (let* ((current-stack (car acc))
                    (current-surviving-l-robots (cadr acc))
                    (processed-result (process-robot-with-stack robot current-stack))
                    (new-stack (car processed-result))
                    (maybe-surviving-l (cadr processed-result)))
               (if maybe-surviving-l
                   ;; If an L robot survived, add it to the list of surviving L robots.
                   (list new-stack (cons maybe-surviving-l current-surviving-l-robots))
                   ;; Otherwise, just update the stack.
                   (list new-stack current-surviving-l-robots))))
           (list '() '()) ; Initial accumulator: (empty-stack empty-survivors-list)
           sorted-robots))

  (define final-stack (car final-state))
  (define final-surviving-l-robots (cadr final-state))

  ;; Combine all surviving robots (those remaining on the stack and the L robots that survived).
  ;; Sort them by their original index to get the final result order.
  (define all-survivors
    (sort (append final-stack final-surviving-l-robots)
          (lambda (r1 r2) (< (list-ref r1 0) (list-ref r2 0)))))

  ;; Extract the healths of the surviving robots.
  (map (lambda (robot) (list-ref robot 2)) all-survivors))