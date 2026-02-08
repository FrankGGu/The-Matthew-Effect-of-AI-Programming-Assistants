#lang racket

(struct Cell (row col value))
(struct Spreadsheet (cells))

(define (Spreadsheet)
  (Spreadsheet (hash)))

(define (set-cell spreadsheet row col value)
  (hash-set! (Spreadsheet-cells spreadsheet) (list row col) (Cell row col value))
  spreadsheet)

(define (get-cell spreadsheet row col)
  (define cell (hash-ref (Spreadsheet-cells spreadsheet) (list row col) #f))
  (if cell
      (Cell-value cell)
      ""))

(define (sum spreadsheet row col ranges)
  (define total (for/sum ([range ranges])
                   (define vals (string-split range ":"))
                   (define start (map string->number (string-split (first vals) ",")))
                   (define end (map string->number (string-split (second vals) ",")))
                   (for/sum ([r (in-range (first start) (+ (first end) 1))])
                     (for/sum ([c (in-range (second start) (+ (second end) 1))])
                       (define cell (hash-ref (Spreadsheet-cells spreadsheet) (list r c) #f))
                       (if cell
                           (Cell-value cell)
                           0))))
  total)

(define (create-spreadsheet)
  (Spreadsheet))

(define (set-value spreadsheet row col value)
  (set-cell spreadsheet row col value))

(define (get-value spreadsheet row col)
  (get-cell spreadsheet row col))

(define (sum-values spreadsheet row col ranges)
  (sum spreadsheet row col ranges))