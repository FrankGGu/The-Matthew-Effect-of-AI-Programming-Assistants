(define (modify-string s)
  (let loop ([str (string->list s)]
             [idx 0])
    (cond
      [(= idx (length str)) (list->string str)]
      [(= (list-ref str idx) #\?)
       (let ([chars (list #\a #\b #\c)])
         (letrec ([find-valid-char (lambda (chars)
                                     (cond
                                       [(null? chars) #f]
                                       [else
                                        (let ([c (car chars)])
                                          (and
                                           (or (= idx 0) (not (equal? c (list-ref str (- idx 1)))))
                                           (or (= (+ idx 1) (length str)) (not (equal? c (list-ref str (+ idx 1)))))
                                           c))])])
           (let ([valid-char (find-valid-char chars)])
             (cond
               [(not valid-char) (error "No valid character found")]
               [else (loop (list-set str idx valid-char) (+ idx 1))]))))]
      [else (loop str (+ idx 1))])))