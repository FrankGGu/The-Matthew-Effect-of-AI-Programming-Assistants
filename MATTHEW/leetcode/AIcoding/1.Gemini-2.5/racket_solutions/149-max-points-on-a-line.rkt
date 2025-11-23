#lang racket

(define (max-points-on-a-line points)
  (define num-points (length points))

  (cond
    ((<= num-points 2) num-points)
    (else
     (define max-val 0)
     (for ([i (in-range num-points)])
       (define p1 (list-ref points i))
       (define x1 (car p1))
       (define y1 (cadr p1))

       (define slopes (make-hash))
       (define duplicate-points 0)
       (define current-max-for-p1 0)

       (for ([j (in-range num-points)])
         (when (not (= i j))
           (define p2 (list-ref points j))
           (define x2 (car p2))
           (define y2 (cadr p2))

           (cond
             ((and (= x1 x2) (= y1 y2))
              (set! duplicate-points (+ duplicate-points 1)))
             (else
              (define dx (- x2 x1))
              (define dy (- y2 y1))

              (define slope-key
                (cond
                  ((= dx 0) '(vertical))
                  ((= dy 0) '(horizontal))
                  (else
                   (define common-divisor (gcd (abs dx) (abs dy)))
                   (define reduced-dx (/ dx common-divisor))
                   (define reduced-dy (/ dy common-divisor))
                   (if (< reduced-dx 0)
                       (cons (- reduced-dy) (- reduced-dx))
                       (cons reduced-dy reduced-dx))))))

              (hash-set! slopes slope-key (+ (hash-ref slopes slope-key 0) 1))
              (set! current-max-for-p1 (max current-max-for-p1 (hash-ref slopes slope-key 0)))))))

       (set! max-val (max max-val (+ current-max-for-p1 duplicate-points 1))))
     max-val)))