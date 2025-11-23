#lang racket

(struct text-editor (left right) #:mutable #:transparent)

(define (make-text-editor)
  (text-editor '() '()))

(define (add-text editor text)
  (set-text-editor-left! editor (append (text-editor-left editor) (string->list text))))

(define (delete-text editor k)
  (let* ([left (text-editor-left editor)]
         [n (length left)]
         [delete-count (min k n)])
    (set-text-editor-left! editor (drop left delete-count))
    delete-count))

(define (cursor-left editor k)
  (let* ([left (text-editor-left editor)]
         [right (text-editor-right editor)]
         [n (length left)]
         [move (min k n)])
    (set-text-editor-left! editor (take left (- n move)))
    (set-text-editor-right! editor (append (reverse (take-right left move)) right))
    (let ([left (text-editor-left editor)])
      (list->string (take-right left (min 10 (length left))))))

(define (cursor-right editor k)
  (let* ([left (text-editor-left editor)]
         [right (text-editor-right editor)]
         [n (length right)]
         [move (min k n)))
    (set-text-editor-left! editor (append left (reverse (take right move))))
    (set-text-editor-right! editor (drop right move))
    (let ([left (text-editor-left editor)])
      (list->string (take-right left (min 10 (length left))))))