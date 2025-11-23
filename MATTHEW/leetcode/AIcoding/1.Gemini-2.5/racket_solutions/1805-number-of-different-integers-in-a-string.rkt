#lang racket

(define (normalize-number num-str)
  (if (string=? num-str "0")
      "0"
      (let ([stripped (string-drop-while (lambda (c) (char=? c #\0)) num-str)])
        (if (string-empty? stripped)
            "0" ; Handles cases like "000" -> "0"
            stripped))))

(define (num-different-integers word)
  (let ([unique-numbers (set)]
        [current-number-chars '()] ; List of characters for the current number
        [len (string-length word)])
    (for ([i (in-range len)])
      (let ([char (string-ref word i)])
        (if (char-numeric? char)
            (set! current-number-chars (cons char current-number-chars)) ; Prepend char
            (begin
              (when (not (empty? current-number-chars))
                (set! unique-numbers (set-add unique-numbers (normalize-number (list->string (reverse current-number-chars))))))
              (set! current-number-chars '())))))
    ;; Handle any number at the end of the string
    (when (not (empty? current-number-chars))
      (set! unique-numbers (set-add unique-numbers (normalize-number (list->string (reverse current-number-chars))))))
    (set-count unique-numbers)))