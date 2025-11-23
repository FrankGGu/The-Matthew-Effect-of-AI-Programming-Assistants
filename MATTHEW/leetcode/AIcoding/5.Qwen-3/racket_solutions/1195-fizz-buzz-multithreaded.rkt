#lang racket

(define (fizz? n) (= (modulo n 3) 0))
(define (buzz? n) (= (modulo n 15) 0))
(define (fizzbuzz? n) (= (modulo n 15) 0))
(define (number? n) (not (or (fizz? n) (buzz? n) (fizzbuzz? n))))

(define (fizz-notify! cond-var)
  (call-with-semaphore
   (current-thread)
   (lambda ()
     (when (not (fizz? (current-count)))
       (wait-on-semaphore cond-var))
     (printf "Fizz\n")
     (set! (current-count) (+ (current-count) 1))
     (signal-semaphore cond-var))))

(define (buzz-notify! cond-var)
  (call-with-semaphore
   (current-thread)
   (lambda ()
     (when (not (buzz? (current-count)))
       (wait-on-semaphore cond-var))
     (printf "Buzz\n")
     (set! (current-count) (+ (current-count) 1))
     (signal-semaphore cond-var))))

(define (fizzbuzz-notify! cond-var)
  (call-with-semaphore
   (current-thread)
   (lambda ()
     (when (not (fizzbuzz? (current-count)))
       (wait-on-semaphore cond-var))
     (printf "FizzBuzz\n")
     (set! (current-count) (+ (current-count) 1))
     (signal-semaphore cond-var))))

(define (number-notify! cond-var)
  (call-with-semaphore
   (current-thread)
   (lambda ()
     (when (not (number? (current-count)))
       (wait-on-semaphore cond-var))
     (printf "~a\n" (current-count))
     (set! (current-count) (+ (current-count) 1))
     (signal-semaphore cond-var))))

(define current-count (make-parameter 1))
(define cond-var (make-semaphore 1))

(define (main n)
  (let ([t1 (thread (lambda () (for ([i (in-range n)])(fizz-notify! cond-var))))]
        [t2 (thread (lambda () (for ([i (in-range n)])(buzz-notify! cond-var))))]
        [t3 (thread (lambda () (for ([i (in-range n)])(fizzbuzz-notify! cond-var))))]
        [t4 (thread (lambda () (for ([i (in-range n)])(number-notify! cond-var))))]
        )
    (sleep 1)))

(main 100)