#lang racket

(require racket/semaphore)

(define-struct (Foo #:mutable) (sem1 sem2))

(define (Foo-first this printFirst)
  (printFirst)
  (semaphore-post (Foo-sem1 this)))

(define (Foo-second this printSecond)
  (semaphore-wait (Foo-sem1 this))
  (printSecond)
  (semaphore-post (Foo-sem2 this)))

(define (Foo-third this printThird)
  (semaphore-wait (Foo-sem2 this))
  (printThird))

(define (Foo-new)
  (make-Foo (make-semaphore 0) (make-semaphore 0)))