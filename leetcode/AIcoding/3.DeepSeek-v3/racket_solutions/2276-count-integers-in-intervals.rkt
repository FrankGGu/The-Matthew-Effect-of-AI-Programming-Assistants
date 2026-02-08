(define count 0)
(define intervals '())

(define (add-interval left right)
  (let loop ([lst intervals]
             [new-intervals '()]
             [merged-left left]
             [merged-right right])
    (cond
      [(null? lst)
       (set! intervals (cons (cons merged-left merged-right) new-intervals))
       (set! count (+ count (- merged-right merged-left -1)))]
      [else
       (let* ([current (car lst)]
              [current-left (car current)]
              [current-right (cdr current)])
         (cond
           [(> merged-left current-right)
            (loop (cdr lst) (cons current new-intervals) merged-left merged-right)]
           [(< merged-right current-left)
            (loop (cdr lst) (cons current new-intervals) merged-left merged-right)]
           [else
            (loop (cdr lst)
                  new-intervals
                  (min merged-left current-left)
                  (max merged-right current-right))]))])))

(define (count-intervals)
  count)