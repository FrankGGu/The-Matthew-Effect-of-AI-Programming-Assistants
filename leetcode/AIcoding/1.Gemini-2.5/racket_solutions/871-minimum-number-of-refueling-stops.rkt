#lang racket

(define (min-refuel-stops target startFuel stations-list)
  (call-with-current-continuation
   (lambda (return)
     (let* ([stations-augmented (vector-append (list->vector stations-list) (vector (list target 0)))]
            [n (vector-length stations-augmented)]
            [current-fuel startFuel]
            [stops 0]
            [prev-pos 0])

       (define (make-max-heap)
         (let ([data (make-vector 10 #f)]
               [size 0])
           (define (grow-if-needed!)
             (when (= size (vector-length data))
               (let* ([new-capacity (max 10 (* 2 (vector-length data)))]
                      [new-data (make-vector new-capacity #f)])
                 (for ([i (in-range size)])
                   (vector-set! new-data i (vector-ref data i)))
                 (set! data new-data))))

           (define (parent i) (quotient (- i 1) 2))
           (define (left-child i) (+ (* 2 i) 1))
           (define (right-child i) (+ (* 2 i) 2))

           (define (swap! i j)
             (let ([temp (vector-ref data i)])
               (vector-set! data i (vector-ref data j))
               (vector-set! data j temp)))

           (define (bubble-up! i)
             (let ([p (parent i)])
               (when (and (> i 0) (> (vector-ref data i) (vector-ref data p)))
                 (swap! i p)
                 (bubble-up! p))))

           (define (bubble-down! i)
             (let ([l (left-child i)]
                   [r (right-child i)]
                   [largest i])
               (when (and (< l size) (> (vector-ref data l) (vector-ref data largest)))
                 (set! largest l))
               (when (and (< r size) (> (vector-ref data r) (vector-ref data largest)))
                 (set! largest r))
               (when (not (= largest i))
                 (swap! i largest)
                 (bubble-down! largest))))

           (define (heap-add! val)
             (grow-if-needed!)
             (vector-set! data size val)
             (set! size (+ size 1))
             (bubble-up! (- size 1)))

           (define (heap-pop!)
             (let ([max-val (vector-ref data 0)])
               (set! size (- size 1))
               (when (> size 0)
                 (vector-set! data 0 (vector-ref data size))
                 (bubble-down! 0))
               max-val))

           (define (heap-empty?) (= size 0))

           (list heap-add! heap-pop! heap-empty?)))

       (define-values (heap-add! heap-pop! heap-empty?) (make-max-heap))

       (for ([i (in-range n)])
         (let* ([station (vector-ref stations-augmented i)]
                [pos (car station)]
                [fuel (cadr station)]
                [dist-to-next-stop (- pos prev-pos)])

           (let loop-refuel ()
             (when (< current-fuel dist-to-next-stop)
               (when (heap-empty?)
                 (return -1))
               (set! current-fuel (+ current-fuel (heap-pop!)))
               (set! stops (+ stops 1))
               (loop-refuel)))

           (set! current-fuel (- current-fuel dist-to-next-stop))
           (heap-add! fuel)
           (set! prev-pos pos)))

       stops))))