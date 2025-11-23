#lang racket

(define (shortest-uncommon-substring arr)
  (define (get-all-substrings s)
    (for*/list ([i (in-range (string-length s))]
                [j (in-range (+ i 1) (+ (string-length s) 1))])
      (substring s i j)))

  (define substrings (map get-all-substrings arr))

  (define (count-substrings ss)
    (for/fold ([counts (hash)])
              ([s ss])
      (hash-update counts s add1 0)))

  (define all-counts (count-substrings (apply append substrings)))

  (define (is-uncommon? s)
    (= 1 (hash-ref all-counts s 0)))

  (define all-substrings (apply append substrings))

  (define candidates (filter is-uncommon? all-substrings))

  (if (null? candidates)
      ""
      (let ([min-len (apply min (map string-length candidates))])
        (car (filter (lambda (s) (= (string-length s) min-len)) candidates)))))