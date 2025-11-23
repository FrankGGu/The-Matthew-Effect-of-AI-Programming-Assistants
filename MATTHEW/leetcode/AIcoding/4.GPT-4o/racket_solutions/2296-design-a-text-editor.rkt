#lang racket

(define TextEditor
  (class object%
    (init)
    (define/override (init)
      (set! text "")
      (set! cursor 0))
    (define text "")
    (define cursor 0)

    (define/public (add-text txt)
      (set! text (string-append (substring text 0 cursor) txt (substring text cursor)))
      (set! cursor (+ cursor (string-length txt))))

    (define/public (delete-text k)
      (define delete-count (min k (max 0 cursor)))
      (set! text (substring text 0 (- cursor delete-count)))
      (set! cursor (- cursor delete-count)))

    (define/public (cursor-left k)
      (set! cursor (max 0 (- cursor k))))

    (define/public (cursor-right k)
      (set! cursor (min (string-length text) (+ cursor k))))

    (define/public (get-text)
      text)

    (define/public (get-cursor)
      cursor)))

(define editor (new TextEditor))