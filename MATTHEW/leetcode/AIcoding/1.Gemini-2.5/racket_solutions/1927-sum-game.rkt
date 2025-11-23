#lang racket

(define (sum-game num)
  (let* ([n (string-length num)]
         [half-n (/ n 2)]
         [s-left 0]
         [q-left 0]
         [s-right 0]
         [q-right 0])

    (for ([i (in-range half-n)])
      (let ([char (string-ref num i)])
        (if (char=? char #\?)
            (set! q-left (+ q-left 1))
            (set! s-left (+ s-left (- (char->integer char) (char->integer #\0)))))))

    (for ([i (in-range half-n n)])
      (let ([char (string-ref num i)])
        (if (char=? char #\?)
            (set! q-right (+ q-right 1))
            (set! s-right (+ s-right (- (char->integer char) (char->integer #\0)))))))

    (let* ([s-diff (- s-left s-right)]
           [q-diff (- q-left q-right)])

      (let ([bob-wins-condition
             (if (even? q-diff)
                 (= (+ (* 2 s-diff) (* 9 q-diff)) 0)
                 (if (> q-diff 0)
                     (= (+ (* 2 s-diff) (* 9 (+ q-diff 1))) 0)
                     (= (+ (* 2 s-diff) (* 9 (- q-diff 1))) 0)))])

        (not bob-wins-condition)))))