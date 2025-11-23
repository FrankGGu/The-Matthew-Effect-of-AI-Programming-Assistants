#lang racket

(define (deleteNode node)
  (set! (node-value node) (node-value (next node)))
  (set! (next node) (next (next node))))