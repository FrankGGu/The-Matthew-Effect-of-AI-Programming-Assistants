#lang racket

(define (is-unique? lst)
  (define (helper lst seen)
    (cond
      [(null? lst) #t]
      [(member (car lst) seen) #f]
      [else (helper (cdr lst) (cons (car lst) seen))]))
  (helper lst '()))

(define (string->number str mapping)
  (foldl (lambda (char acc)
            (+ (* acc 10) (map-ref mapping char)))
          0
          (string->list str)))

(define (map-ref mapping char)
  (if (hash-has-key? mapping char)
      (hash-ref mapping char)
      0))

(define (is-valid? words result mapping)
  (let ([sum (foldl (lambda (word acc) (+ (string->number word mapping) acc)) 0 words)])
    (equal? sum (string->number result mapping))))

(define (backtrack words result mapping used)
  (if (equal? (hash-count mapping) (length (remove-duplicates (apply append (map string->list words)))))
      (if (is-valid? words result mapping)
          #t
          #f)
      (for/fold ([found #f]) ([char (remove-duplicates (apply append (map string->list words))) (not found)])
        (for ([digit (in-range 10)])
          (when (and (not (hash-has-key? mapping char))
                     (or (not used) (not (= digit 0))))
            (hash-set! mapping char digit)
            (set! found (or found (backtrack words result mapping (cons char used)))
            (hash-remove! mapping char))))))
  found)

(define (is-solution? words result)
  (let ([mapping (make-hash)])
    (backtrack words result mapping '())))

(define (is-solution? words result)
  (let ([mapping (make-hash)] )
    (define (helper words result)
      (if (or (null? words) (null? result))
          (is-valid? words result mapping)
          (for ([digit (in-range 10)])
            (hash-set! mapping (car words) digit)
            (if (helper (cdr words) result)
                (begin (hash-remove! mapping (car words)) #t)
                (hash-remove! mapping (car words)))))
    (helper words result)))

(define (is-sum-solution? words result)
  (define used (make-hash))
  (define letters (remove-duplicates (apply append (map string->list (cons result words)))))
  (and (is-unique? letters) (is-solution? words result)))

(define (is-sum-solution? words result)
  (let ([mapping (make-hash)])
    (define (backtrack i)
      (if (= i (length words))
          (is-valid? words result mapping)
          (for ([digit (in-range 10)])
            (when (and (not (hash-has-key? mapping (list-ref words i)))
                       (or (= digit 0) (not (string-contains? (list-ref words i) (string (list-ref (list-ref words i) 0))))))
              (hash-set! mapping (list-ref words i) digit)
              (when (backtrack (+ i 1))
                (begin (hash-remove! mapping (list-ref words i)) #t))))))
    (backtrack 0)))

(define (isSumEqual first second target)
  (is-sum-solution? (list first second) target))