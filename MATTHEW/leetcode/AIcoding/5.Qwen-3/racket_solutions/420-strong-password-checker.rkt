#lang racket

(define (strong-password-checker password)
  (define len (string-length password))
  (define has-lower (regexp-match? #rx"[a-z]" password))
  (define has-upper (regexp-match? #rx"[A-Z]" password))
  (define has-digit (regexp-match? #rx"[0-9]" password))
  (define missing (if has-lower 1 0) + (if has-upper 1 0) + (if has-digit 1 0))

  (define (count-repeats s)
    (let loop ([i 0] [count 0] [prev #f] [repeats '()])
      (if (= i (string-length s))
          (reverse repeats)
          (let ([c (string-ref s i)])
            (if (and prev (char=? c prev))
                (loop (+ i 1) (+ count 1) c repeats)
                (loop (+ i 1) 1 c (cons count repeats)))))))

  (define repeats (count-repeats password))

  (cond
    [(<= len 5) (max (- 6 len) missing)]
    [(<= len 6) (max (if (> missing 0) 1 0) (apply max (map (lambda (x) (if (> x 2) (- x 2) 0)) repeats)))]
    [(<= len 20) 
     (let ([need (max 0 (- missing (apply + (map (lambda (x) (if (> x 2) 1 0)) repeats))))])
       (+ need (apply + (map (lambda (x) (if (> x 2) (- x 2) 0)) repeats))))]
    [else
     (let* ([extra (- len 20)]
            [mod2 (filter (lambda (x) (= (remainder x 3) 0)) repeats)]
            [mod1 (filter (lambda (x) (= (remainder x 3) 1)) repeats)]
            [mod0 (filter (lambda (x) (= (remainder x 3) 2)) repeats)])
       (let loop ([extra extra]
                  [mod2 mod2]
                  [mod1 mod1]
                  [mod0 mod0]
                  [res 0])
         (cond
           [(= extra 0) res]
           [(and (not (null? mod2)) (> extra 0))
            (loop (- extra 1) (cdr mod2) mod1 mod0 (+ res 1))]
           [(and (not (null? mod1)) (> extra 0))
            (loop (- extra 1) mod2 (cdr mod1) mod0 (+ res 1))]
           [(and (not (null? mod0)) (> extra 0))
            (loop (- extra 1) mod2 mod1 (cdr mod0) (+ res 1))]
           [else
            (let ([cnt (min (length mod2) (quotient extra 2))])
              (loop (- extra (* cnt 2)) (drop mod2 cnt) mod1 mod0 (+ res cnt)))
            (let ([cnt (min (length mod1) (quotient extra 1))])
              (loop (- extra cnt) mod2 (drop mod1 cnt) mod0 (+ res cnt)))
            (let ([cnt (min (length mod0) (quotient extra 1))])
              (loop (- extra cnt) mod2 mod1 (drop mod0 cnt) (+ res cnt)))])
         ))])])