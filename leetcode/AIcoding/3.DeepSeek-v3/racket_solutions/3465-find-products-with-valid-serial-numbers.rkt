#lang racket

(define (valid-serial? serial)
  ; 根据题目要求实现验证逻辑
  #t)

(define (find-valid-products products)
  (filter valid-serial? products))

(define products '("A123", "B456", "INVALID", "C789"))
(find-valid-products products)