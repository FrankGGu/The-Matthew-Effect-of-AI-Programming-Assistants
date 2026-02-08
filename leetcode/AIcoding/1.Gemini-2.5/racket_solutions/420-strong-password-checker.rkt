#lang racket

(define (strong-password-checker password)
  (define n (string-length password))

  (define has-lower? #f)
  (define has-upper? #f)
  (define has-digit? #f)

  (for ([char (in-string password)])
    (when (char-lower-case? char) (set! has-lower? #t))
    (when (char-upper-case? char) (set! has-upper? #t))
    (when (char-digit? char) (set! has-digit? #t)))

  (define missing-types
    (+ (if has-lower? 0 1)
       (if has-upper? 0 1)
       (if has-digit? 0 1)))

  (define repeating-lengths '())
  (when (> n 0)
    (let loop ([i 0])
      (when (< i n)
        (let ([current-char (string-ref password i)])
          (let loop-inner ([j (+ i 1)])
            (if (and (< j n) (char=? (string-ref password j) current-char))
                (loop-inner (+ j 1))
                (begin
                  (let ([len (- j i)])
                    (when (>= len 3)
                      (set! repeating-lengths (cons len repeating-lengths))))
                  (loop j))))))))

  (define total-repeats-violations (for/sum ([l repeating-lengths]) (floor l 3)))

  (cond
    [(< n 6)
     (max (- 6 n) missing-types total-repeats-violations)]

    [(> n 20)
     (let* ([deletions-needed (- n 20)]
            [ops deletions-needed]
            [deletions-available deletions-needed]
            [fixed-repeats 0]
            [groups-mod-0 '()]
            [groups-mod-1 '()]
            [groups-mod-2 '()])

       (for ([l repeating-lengths])
         (case (modulo l 3)
           [0 (set! groups-mod-0 (cons (floor l 3) groups-mod-0))]
           [1 (set! groups-mod-1 (cons (floor l 3) groups-mod-1))]
           [2 (set! groups-mod-2 (cons (floor l 3) groups-mod-2))]))

       (for ([r groups-mod-0])
         (when (> deletions-available 0)
           (let ([can-fix (min deletions-available r)])
             (set! fixed-repeats (+ fixed-repeats can-fix))
             (set! deletions-available (- deletions-available can-fix)))))

       (for ([r groups-mod-1])
         (when (>= deletions-available 2)
           (let ([can-fix (min (floor deletions-available 2) r)])
             (set! fixed-repeats (+ fixed-repeats can-fix))
             (set! deletions-available (- deletions-available (* can-fix 2))))))

       (for ([r groups-mod-2])
         (when (>= deletions-available 3)
           (let ([can-fix (min (floor deletions-available 3) r)])
             (set! fixed-repeats (+ fixed-repeats can-fix))
             (set! deletions-available (- deletions-available (* can-fix 3))))))

       (define remaining-repeats-to-fix (- total-repeats-violations fixed-repeats))
       (+ ops (max missing-types remaining-repeats-to-fix))]

    [else
     (max missing-types total-repeats-violations)]))