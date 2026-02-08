#lang racket

(define (smallest-palindromic-rearrangement-ii s)
  (let* ([char-counts (make-hash)]
         [first-half-chars '()]
         [middle-char #f]
         [odd-count-chars '()])

    (for ([c (in-string s)])
      (hash-update! char-counts c add1 0))

    (hash-for-each char-counts
                   (lambda (char count)
                     (when (odd? count)
                       (set! odd-count-chars (cons char odd-count-chars)))
                     (for ([_ (in-range (quotient count 2))])
                       (set! first-half-chars (cons char first-half-chars)))))

    (if (> (length odd-count-chars) 1)
        ""
        (let* ([sorted-first-half-list (sort first-half-chars char<?)]
               [first-half-str (list->string sorted-first-half-list)]
               [reversed-first-half-str (list->string (reverse sorted-first-half-list))])
          (when (= (length odd-count-chars) 1)
            (set! middle-char (car odd-count-chars)))

          (if middle-char
              (string-append first-half-str (string middle-char) reversed-first-half-str)
              (string-append first-half-str reversed-first-half-str))))))