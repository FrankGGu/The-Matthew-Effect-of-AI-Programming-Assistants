(define (is-valid? first-word second-word result-word)
  (let* ((chars (append (string->list first-word) (string->list second-word) (string->list result-word)))
         (unique-chars (remove-duplicates chars))
         (mapping (make-hash))
         (possible-digits (build-list 10 identity)))

    (define (solve)
      (define (helper chars digits)
        (cond
          [(empty? chars)
           (let ((first-num (string->number (list->string (map (lambda (c) (number->string (hash-ref mapping c))) (string->list first-word)))))
                 (second-num (string->number (list->string (map (lambda (c) (number->string (hash-ref mapping c))) (string->list second-word)))))
                 (result-num (string->number (list->string (map (lambda (c) (number->string (hash-ref mapping c))) (string->list result-word))))))
             (and first-num second-num result-num (= (+ first-num second-num) result-num)
                  (not (and (> (string-length first-word) 1) (= (hash-ref mapping (string-ref first-word 0)) 0)))
                  (not (and (> (string-length second-word) 1) (= (hash-ref mapping (string-ref second-word 0)) 0)))
                  (not (and (> (string-length result-word) 1) (= (hash-ref mapping (string-ref result-word 0)) 0)))))
          [(empty? digits) #f]
          [else
           (let ((char (car chars)))
             (if (hash-has-key? mapping char)
                 (helper (cdr chars) digits)
                 (for/or ((digit (in-list digits)))
                   (begin
                     (hash-set! mapping char digit)
                     (if (helper (cdr chars) (remove digit digits))
                         #t
                         (begin
                           (hash-remove! mapping char)
                           #f))))))]))
      (helper unique-chars possible-digits))

    (solve)))