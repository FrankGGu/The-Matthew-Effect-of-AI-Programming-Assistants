#lang racket

(define (subseqs-with-unique-middle-mode nums)
  (define n (length nums))
  (define (count-freq lst)
    (define freq (make-hash))
    (for-each (lambda (x) (hash-set! freq x (+ 1 (hash-ref freq x 0)))) lst)
    freq)

  (define (mode lst)
    (define freq (count-freq lst))
    (define max-count 0)
    (define mode-val #f)
    (for ([k (in-hash-keys freq)])
      (define cnt (hash-ref freq k))
      (cond [(> cnt max-count)
             (set! max-count cnt)
             (set! mode-val k)]
            [(= cnt max-count)
             (set! mode-val #f)]))
    mode-val)

  (define (all-subseqs)
    (let loop ([i 0] [current '()])
      (if (= i n)
          (list current)
          (append (loop (+ i 1) current)
                  (loop (+ i 1) (cons (list-ref nums i) current))))))

  (define subseqs (all-subseqs))
  (define result '())
  (for-each
   (lambda (s)
     (when (and (> (length s) 1) (= (remainder (length s) 2) 1))
       (define mid (quotient (length s) 2))
       (define m (mode (list-ref s mid)))
       (when m
         (set! result (cons s result)))))
  (length result))