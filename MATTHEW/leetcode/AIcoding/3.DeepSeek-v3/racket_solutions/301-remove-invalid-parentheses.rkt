#lang racket

(define (remove-invalid-parentheses s)
  (define (is-valid str)
    (let loop ([i 0] [balance 0])
      (cond
        [(= i (string-length str)) (zero? balance)]
        [(char=? (string-ref str i) #\() (loop (+ i 1) (+ balance 1))]
        [(char=? (string-ref str i) #\)) (and (> balance 0) (loop (+ i 1) (- balance 1)))]
        [else (loop (+ i 1) balance)])))

  (define (helper q visited res)
    (if (null? q)
        res
        (let* ([current (car q)]
               [rest-q (cdr q)]
               [str (car current)]
               [level (cdr current)])
          (if (is-valid str)
              (helper '() visited (cons str res))
              (let loop ([i 0] [new-q rest-q] [new-visited visited])
                (if (>= i (string-length str))
                    (helper new-q new-visited res)
                    (let ([c (string-ref str i)])
                      (if (or (not (char=? c #\()) (not (char=? c #\))))
                          (loop (+ i 1) new-q new-visited)
                          (let ([new-str (string-append (substring str 0 i) (substring str (+ i 1)))])
                            (if (set-member? new-visited new-str)
                                (loop (+ i 1) new-q new-visited)
                                (loop (+ i 1) (cons (cons new-str (+ level 1)) new-q) (set-add new-visited new-str))))))))))))

  (define initial-visited (mutable-set))
  (set-add! initial-visited s)
  (let ([result (helper (list (cons s 0)) initial-visited '())])
    (if (null? result)
        (list "")
        (remove-duplicates result))))