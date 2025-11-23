#lang racket

(define (getMinSwaps num k)
  (define s (string->list (number->string num)))
  (define original (string-copy (list->string s)))
  (define len (length s))

  (define (next-permutation lst)
    (let loop ([i (- len 2)])
      (cond
        [(< i 0) (reverse lst)]
        [(char<? (list-ref lst i) (list-ref lst (+ i 1)))
         (let* ([j (let find-j ([j (- len 1)])
                     (if (char>? (list-ref lst j) (list-ref lst i))
                         j
                         (find-j (- j 1))))]
                [swapped (swap lst i j)])
           (append (take swapped (+ i 1))
                   (reverse (drop swapped (+ i 1)))))]
        [else (loop (- i 1))])))

  (define (swap lst i j)
    (let ([tmp (list-ref lst i)])
      (list-set (list-set lst i (list-ref lst j)) j tmp)))

  (define (apply-permutations s k)
    (if (= k 0)
        s
        (apply-permutations (next-permutation s) (- k 1))))

  (define target (apply-permutations s k))
  (define target-str (list->string target))

  (define (count-swaps original target)
    (let loop ([i 0] [swaps 0])
      (if (>= i len)
          swaps
          (if (char=? (string-ref original i) (string-ref target i))
              (loop (+ i 1) swaps)
              (let ([j (let find-j ([j i])
                         (if (char=? (string-ref original j) (string-ref target i))
                             j
                             (find-j (+ j 1))))])
                (loop (+ i 1) 
                      (+ swaps (- j i))
                      (string-append (substring original 0 i)
                                    (substring target i (+ i 1))
                                    (substring original i j)
                                    (substring original (+ j 1))))))))))

  (count-swaps original target-str))