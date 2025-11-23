#lang racket

(require racket/sync)

(define (fizzbuzz n-val)
  (define current-num (box 1))
  (define m (make-mutex))

  (define fizz-sem (make-semaphore 0))
  (define buzz-sem (make-semaphore 0))
  (define fizzbuzz-sem (make-semaphore 0))
  (define number-sem (make-semaphore 1))

  (define (post-next-semaphore! current-val)
    (cond
      [(> current-val n-val)
       (semaphore-post fizz-sem)
       (semaphore-post buzz-sem)
       (semaphore-post fizzbuzz-sem)
       (semaphore-post number-sem)]
      [(and (zero? (remainder current-val 3)) (zero? (remainder current-val 5)))
       (semaphore-post fizzbuzz-sem)]
      [(zero? (remainder current-val 3))
       (semaphore-post fizz-sem)]
      [(zero? (remainder current-val 5))
       (semaphore-post buzz-sem)]
      [else
       (semaphore-post number-sem)]))

  (define (fizz)
    (let loop ()
      (semaphore-wait fizz-sem)
      (mutex-acquire m)
      (let ([val (unbox current-num)])
        (cond
          [(> val n-val)
           (post-next-semaphore! val)
           (mutex-release m)
           (void)]
          [(and (zero? (remainder val 3)) (not (zero? (remainder val 5))))
           (display "fizz")
           (newline)
           (set-box! current-num (+ val 1))
           (post-next-semaphore! (unbox current-num))
           (mutex-release m)
           (loop)]
          [else
           (post-next-semaphore! val)
           (mutex-release m)
           (loop)]))))

  (define (buzz)
    (let loop ()
      (semaphore-wait buzz-sem)
      (mutex-acquire m)
      (let ([val (unbox current-num)])
        (cond
          [(> val n-val)
           (post-next-semaphore! val)
           (mutex-release m)
           (void)]
          [(and (zero? (remainder val 5)) (not (zero? (remainder val 3))))
           (display "buzz")
           (newline)
           (set-box! current-num (+ val 1))
           (post-next-semaphore! (unbox current-num))
           (mutex-release m)
           (loop)]
          [else
           (post-next-semaphore! val)
           (mutex-release m)
           (loop)]))))

  (define (fizzbuzz)
    (let loop ()
      (semaphore-wait fizzbuzz-sem)
      (mutex-acquire m)
      (let ([val (unbox current-num)])
        (cond
          [(> val n-val)
           (post-next-semaphore! val)
           (mutex-release m)
           (void)]
          [(and (zero? (remainder val 3)) (zero? (remainder val 5)))
           (display "fizzbuzz")
           (newline)
           (set-box! current-num (+ val 1))
           (post-next-semaphore! (unbox current-num))
           (mutex-release m)
           (loop)]
          [else
           (post-next-semaphore! val)
           (mutex-release m)
           (loop)]))))

  (define (number)
    (let loop ()
      (semaphore-wait number-sem)
      (mutex-acquire m)
      (let ([val (unbox current-num)])
        (cond
          [(> val n-val)
           (post-next-semaphore! val)
           (mutex-release m)
           (void)]
          [(and (not (zero? (remainder val 3))) (not (zero? (remainder val 5))))
           (display val)
           (newline)
           (set-box! current-num (+ val 1))
           (post-next-semaphore! (unbox current-num))
           (mutex-release m)
           (loop)]
          [else
           (post-next-semaphore! val)
           (mutex-release m)
           (loop)]))))

  (define t-fizz (thread fizz))
  (define t-buzz (thread buzz))
  (define t-fizzbuzz (thread fizzbuzz))
  (define t-number (thread number))

  (thread-wait t-fizz)
  (thread-wait t-buzz)
  (thread-wait t-fizzbuzz)
  (thread-wait t-number))