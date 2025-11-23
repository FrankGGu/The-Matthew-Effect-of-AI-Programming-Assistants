#lang racket

(require racket/list)
(require racket/string)

(define (get-all-palindromes-around n)
  (let* ((s (number->string n))
         (len (string-length s))
         (half-len (ceiling (/ len 2)))
         (first-half-str (substring s 0 half-len))
         (first-half-num (string->number first-half-str))
         (candidates (list)))

    (define (add-pal s_h)
      (let ((s_h_len (string-length s_h)))
        ;; Try odd length palindrome
        ;; e.g., s_h = "123", result = "12321" (reverse "12")
        (set! candidates (cons (string->number (string-append s_h (string-reverse (substring s_h 0 (- s_h_len 1))))) candidates))
        ;; Try even length palindrome
        ;; e.g., s_h = "12", result = "1221" (reverse "12")
        (set! candidates (cons (string->number (string-append s_h (string-reverse s_h))) candidates))))

    ;; Candidate 1: Palindromes generated from n's first half
    (add-pal first-half-str)

    ;; Candidate 2: Palindromes generated from (first-half-num - 1)
    (let* ((prev-half-num (- first-half-num 1)))
      (when (>= prev-half-num 0)
        (add-pal (number->string prev-half-num))))

    ;; Candidate 3: Palindromes generated from (first-half-num + 1)
    (let* ((next-half-num (+ first-half-num 1)))
      (add-pal (number->string next-half-num)))

    ;; Add 1-digit palindromes (0-9) as base candidates, as they might be optimal for small numbers
    (for-each (lambda (d) (set! candidates (cons d candidates))) (range 0 10))

    ;; Filter out duplicates and values outside the relevant range (0 to 10^9 + 1 for potential optimal values)
    (remove-duplicates (filter (lambda (p) (and (>= p 0) (<= p 1000000001))) candidates))))

(define (calculate-cost nums p)
  (apply + (map (lambda (x) (abs (- x p))) nums)))

(define (minimum-cost-to-make-array-equalindromic nums)
  (let* ((sorted-nums (sort nums <))
         (n (length sorted-nums))
         (median (list-ref sorted-nums (floor (/ n 2))))
         (candidates (get-all-palindromes-around median)))

    (let loop ((min-cost +inf.0)
               (p-list candidates))
      (if (empty? p-list)
          min-cost
          (let* ((p (car p-list))
                 (current-cost (calculate-cost sorted-nums p)))
            (loop (min min-cost current-cost) (cdr p-list)))))))