#lang racket

(require racket/string)

(define (find-closest-palindrome n)
  (define (make-palindrome-robust half-val total-len)
    (let* ([half-len-target (quotient (add1 total-len) 2)]
           [s-half-raw (number->string half-val)]
           [s-half (if (< (string-length s-half-raw) half-len-target)
                       (string-pad-left s-half-raw half-len-target #\0)
                       (substring s-half-raw 0 half-len-target))]
           [s-half-len-actual (string-length s-half)])
      (string->number
       (if (odd? total-len)
           (string-append s-half (string-reverse (substring s-half 0 (sub1 s-half-len-actual))))
           (string-append s-half (string-reverse s-half))))))

  (let* ([num (string->number n)]
         [len (string-length n)]
         [candidates '()])

    ;; Candidate 1: Largest palindrome with (len-1) digits (all 9s)
    ;; E.g., for n="100", this is 99. For n="1", this is 0.
    (set! candidates (cons (sub1 (expt 10 (sub1 len))) candidates))

    ;; Candidate 2: Smallest palindrome with (len+1) digits (1 followed by len zeros then 1)
    ;; E.g., for n="99", this is 101. For n="1", this is 11.
    (set! candidates (cons (add1 (expt 10 len)) candidates))

    ;; Candidates from modifying the first half of n
    (let* ([half-len-n (quotient (add1 len) 2)]
           [prefix-str (substring n 0 half-len-n)]
           [prefix-val (string->number prefix-str)])

      (set! candidates (cons (make-palindrome-robust prefix-val len) candidates))
      (set! candidates (cons (make-palindrome-robust (sub1 prefix-val) len) candidates))
      (set! candidates (cons (make-palindrome-robust (add1 prefix-val) len) candidates)))

    ;; Filter out the original number itself
    (set! candidates (filter (lambda (x) (not (= x num))) candidates))

    ;; Find the closest palindrome
    (let ([best-cand (car candidates)]
          [min-diff (abs (- (car candidates) num))])
      (for-each (lambda (cand)
                  (let ([diff (abs (- cand num))])
                    (when (< diff min-diff)
                      (set! min-diff diff)
                      (set! best-cand cand))
                    (when (and (= diff min-diff) (< cand best-cand))
                      (set! best-cand cand))))
                (cdr candidates))
      (number->string best-cand))))