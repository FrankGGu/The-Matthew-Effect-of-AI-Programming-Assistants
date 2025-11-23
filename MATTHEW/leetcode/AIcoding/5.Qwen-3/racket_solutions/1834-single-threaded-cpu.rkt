#lang racket

(define (cpu-processor tasks)
  (define (heap-empty? h) (= (length h) 0))
  (define (heap-top h) (car h))
  (define (heap-pop h) (cdr h))
  (define (heap-push h x)
    (define (insert lst x)
      (cond [(null? lst) (list x)]
            [(<= (car lst) x) (cons (car lst) (insert (cdr lst) x))]
            [else (cons x lst)]))
    (insert h x))

  (define (process-tasks tasks)
    (let loop ([time 0]
               [tasks (sort tasks (lambda (a b) (or (< (car a) (car b)) (and (= (car a) (car b)) (< (cadr a) (cadr b)))))]
               [ready-queue '()]
               [result '()])
      (if (and (heap-empty? ready-queue) (null? tasks))
          (reverse result)
          (let ([next-task (if (heap-empty? ready-queue)
                               #f
                               (heap-top ready-queue))])
            (if (and (not (heap-empty? ready-queue)) (<= (car next-task) time))
                (loop time tasks (heap-pop ready-queue) (cons (caddr next-task) result))
                (let ([next-arrival (if (null? tasks) #f (car tasks))])
                  (if (and (not (null? tasks)) (<= (caar tasks) time))
                      (loop time (cdr tasks) (heap-push ready-queue (car tasks)) result)
                      (let ([next-time (if (null? tasks) (if (heap-empty? ready-queue) 0 (car next-task)) (min (caar tasks) (car next-task)))])
                        (loop next-time tasks ready-queue result))))))))

  (process-tasks tasks))

(define (main)
  (define input (read))
  (define tasks (map (lambda (x) (list (car x) (cadr x) (caddr x))) input))
  (define result (cpu-processor tasks))
  (display (string-join (map number->string result) " ")))

(main)