(define (count-integers num1 num2 min_sum max_sum)
  (define MOD 1000000007)
  (define memo (make-hash))

  (define (dp idx sum)
    (cond
      [(>= idx (string-length num2))
       (if (and (>= sum min_sum) (<= sum max_sum))
           1
           0)]
      [(hash-has-key? memo (cons idx sum))
       (hash-ref memo (cons idx sum))]
      [else
       (let* ([limit (string->number (substring num2 idx (+ idx 1)))])
         (define result
           (for/sum ([i (in-range 0 (+ limit 1))])
             (if (<= (+ sum i) max_sum)
                 (dp (+ idx 1) (+ sum i))
                 0)))
         (hash-set! memo (cons idx sum) (modulo result MOD))
         (modulo result MOD))]))

  (define (count-less-or-equal num)
    (hash-clear! memo)
    (define (dp-le idx sum tight)
      (cond
        [(>= idx (string-length num))
         (if (and (>= sum min_sum) (<= sum max_sum))
             1
             0)]
        [(hash-has-key? memo (cons (cons idx sum) tight))
         (hash-ref memo (cons (cons idx sum) tight))]
        [else
         (let* ([limit (string->number (substring num idx (+ idx 1)))]
                [actual-limit (if tight limit 9)])
           (define result
             (for/sum ([i (in-range 0 (+ actual-limit 1))])
               (if (<= (+ sum i) max_sum)
                   (dp-le (+ idx 1) (+ sum i) (and tight (= i limit)))
                   0)))
           (hash-set! memo (cons (cons idx sum) tight) (modulo result MOD))
           (modulo result MOD))]))
    (dp-le 0 0 #t))

  (define (decrement-num num)
    (define len (string-length num))
    (define result (string->list num))
    (define (decrement-helper idx)
      (cond
        [(< idx 0) #f]
        [else
         (let ([digit (string->number (list->string (list (list-ref result idx))))])
           (if (> digit 0)
               (begin (list-set! result idx (string-ref (number->string (- digit 1)) 0)) #t)
               (begin (list-set! result idx #\9) (decrement-helper (- idx 1)))))]))
    (if (decrement-helper (- len 1))
        (list->string result)
        (string-append "0" (list->string result))))

  (define decremented-num1 (decrement-num num1))
  (modulo (- (count-less-or-equal num2) (count-less-or-equal decremented-num1)) MOD))