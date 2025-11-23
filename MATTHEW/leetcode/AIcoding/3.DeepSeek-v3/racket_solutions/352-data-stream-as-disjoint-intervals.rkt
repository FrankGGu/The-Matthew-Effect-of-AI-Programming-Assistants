(define summary-ranges null)

(define (add-num val)
  (let loop ([intervals summary-ranges]
              [left null]
              [found #f])
    (cond
      [(null? intervals)
       (if found
           (set! summary-ranges (reverse left))
           (set! summary-ranges (reverse (cons (list val val) left))))]
      [else
       (let* ([current (car intervals)]
              [s (car current)]
              [e (cadr current)])
       (cond
         [(< val (- s 1))
          (if found
              (set! summary-ranges (append (reverse left) intervals))
              (set! summary-ranges (append (reverse (cons (list val val) left)) intervals)))]
         [(= val (- s 1))
          (set! summary-ranges (append (reverse left) (cons (list val e) (cdr intervals))))]
         [(and (>= val s) (<= val e))
          (set! summary-ranges (append (reverse left) intervals))]
         [(= val (+ e 1))
          (if (and (not (null? (cdr intervals)))
                   (= val (- (caadr intervals) 1)))
              (set! summary-ranges (append (reverse left) (cons (list s (cadadr intervals)) (cddr intervals))))
              (set! summary-ranges (append (reverse left) (cons (list s val) (cdr intervals)))))]
         [(> val (+ e 1))
          (loop (cdr intervals) (cons current left) found)]))])))

(define (get-intervals)
  summary-ranges)