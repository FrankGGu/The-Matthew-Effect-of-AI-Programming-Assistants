#lang racket

(define MOD 1000000007)

(define (calculate-union-length intervals)
  (if (null? intervals)
      0
      (let* ([sorted-intervals (sort intervals (lambda (a b) (< (car a) (car b))))])
        (let loop ([remaining (cdr sorted-intervals)]
                   [merged-so-far (list (car sorted-intervals))])
          (if (null? remaining)
              (apply + (map (lambda (interval) (- (cdr interval) (car interval)))
                            merged-so-far))
              (let* ([current-interval (car remaining)]
                     [last-merged (car merged-so-far)]
                     [prev-y1 (car last-merged)]
                     [prev-y2 (cdr last-merged)]
                     [curr-y1 (car current-interval)]
                     [curr-y2 (cdr current-interval)])
                (if (<= curr-y1 prev-y2)
                    (loop (cdr remaining)
                          (cons (cons prev-y1 (max prev-y2 curr-y2)) (cdr merged-so-far)))
                    (loop (cdr remaining)
                          (cons current-interval merged-so-far)))))))))

(define (add-interval active-intervals y1 y2)
  (let loop ([lst active-intervals])
    (cond
      [(null? lst) (list (cons (cons y1 y2) 1))]
      [(equal? (caar lst) (cons y1 y2))
       (cons (cons (caar lst) (+ (cdar lst) 1)) (cdr lst))]
      [else (cons (car lst) (loop (cdr lst)))])))

(define (remove-interval active-intervals y1 y2)
  (let loop ([lst active-intervals])
    (cond
      [(null? lst) active-intervals]
      [(equal? (caar lst) (cons y1 y2))
       (let ([new-count (- (cdar lst) 1)])
         (if (= new-count 0)
             (cdr lst)
             (cons (cons (caar lst) new-count) (cdr lst))))]
      [else (cons (car lst) (loop (cdr lst)))])))

(define (rectangle-area-ii rectangles)
  (let* ([events '()]
         [total-area 0]
         [active-intervals '()])

    (for-each (lambda (rect)
                (let ([x1 (list-ref rect 0)]
                      [y1 (list-ref rect 1)]
                      [x2 (list-ref rect 2)]
                      [y2 (list-ref rect 3)])
                  (set! events (cons (list x1 y1 y2 1) events))
                  (set! events (cons (list x2 y1 y2 -1) events))))
              rectangles)

    (set! events (sort events (lambda (e1 e2)
                                (let ([x1 (list-ref e1 0)] [type1 (list-ref e1 3)]
                                      [x2 (list-ref e2 0)] [type2 (list-ref e2 3)])
                                  (or (< x1 x2)
                                      (and (= x1 x2) (> type1 type2)))))))

    (when (not (null? events))
      (let ([prev-x (list-ref (car events) 0)])
        (for-each (lambda (event)
                    (let* ([current-x (list-ref event 0)]
                           [y1 (list-ref event 1)]
                           [y2 (list-ref event 2)]
                           [type (list-ref event 3)])

                      (when (> current-x prev-x)
                        (let ([current-y-union-length (calculate-union-length (map car active-intervals))])
                          (set! total-area
                                (modulo (+ total-area
                                           (* (- current-x prev-x) current-y-union-length))
                                        MOD))))

                      (if (= type 1)
                          (set! active-intervals (add-interval active-intervals y1 y2))
                          (set! active-intervals (remove-interval active-intervals y1 y2)))

                      (set! prev-x current-x)))
                  events)))
    total-area))