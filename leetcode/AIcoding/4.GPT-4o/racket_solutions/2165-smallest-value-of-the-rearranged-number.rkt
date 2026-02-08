(define (smallestNumber num)
  (if (= num 0)
      0
      (let* ((neg? (< num 0))
             (digits (map integer->char (map (lambda (x) (+ x 48)) (sort (map abs (map char->integer (string->list (number->string (abs num))))) <)))))
             (first-non-zero (find-first-non-zero digits)))
        (if neg?
            (- (string->number (apply string digits)))
            (string->number (apply string (cons (car first-non-zero) (remove first-non-zero digits))))))))

(define (find-first-non-zero lst)
  (for/fold ([result '()]) ([x lst])
    (if (and (not (equal? x #\0)) (null? result))
        (set! result (list x))
        (if (null? result)
            (list x)
            (append result (list x))))))

(define (remove item lst)
  (filter (lambda (x) (not (equal? x item))) lst))