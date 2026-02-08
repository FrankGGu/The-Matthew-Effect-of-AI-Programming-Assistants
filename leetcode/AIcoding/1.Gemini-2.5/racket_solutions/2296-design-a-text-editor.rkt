#lang racket

(define TextEditor%
  (class object%
    (init-field (left-stack '())   ; Characters to the left of the cursor, in reverse order (stack)
                (right-stack '())) ; Characters to the right of the cursor, in normal order (stack)

    (define/public (addText text)
      (for ([char (string->list text)])
        (set! left-stack (cons char left-stack))))

    (define/public (deleteText k)
      (let loop ([k-rem k] [deleted-count 0])
        (if (and (> k-rem 0) (not (empty? left-stack)))
            (begin
              (set! left-stack (cdr left-stack))
              (loop (- k-rem 1) (+ deleted-count 1)))
            deleted-count)))

    (define/private (get-current-left-text-segment)
      (list->string (reverse (take left-stack (min 10 (length left-stack))))))

    (define/public (cursorLeft k)
      (let loop ([k-rem k])
        (when (and (> k-rem 0) (not (empty? left-stack)))
          (set! right-stack (cons (car left-stack) right-stack))
          (set! left-stack (cdr left-stack))
          (loop (- k-rem 1))))
      (get-current-left-text-segment))

    (define/public (cursorRight k)
      (let loop ([k-rem k])
        (when (and (> k-rem 0) (not (empty? right-stack)))
          (set! left-stack (cons (car right-stack) left-stack))
          (set! right-stack (cdr right-stack))
          (loop (- k-rem 1))))
      (get-current-left-text-segment))))