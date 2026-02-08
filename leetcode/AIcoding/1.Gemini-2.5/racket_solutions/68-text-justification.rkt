(define (text-justification words max-width)
  (define result '())
  (define current-line-words '())
  (define current-word-lengths-sum 0)

  (define (justify-and-add-line words-on-line total-words-len is-last-line)
    (define num-words (length words-on-line))
    (define total-spaces-needed (- max-width total-words-len))
    (define justified-string "")

    (cond
      [(or is-last-line (= num-words 1))
       (set! justified-string
             (string-append
              (string-join words-on-line " ")
              (make-string (- max-width (length (string-join words-on-line " "))) #\space)))]

      [else
       (define num-gaps (- num-words 1))
       (define base-spaces-per-gap (quotient total-spaces-needed num-gaps))
       (define extra-spaces-left (remainder total-spaces-needed num-gaps))

       (define (build-string-parts words-list current-extra-spaces)
         (if (empty? words-list)
             '()
             (cons (car words-list)
                   (if (empty? (cdr words-list))
                       '()
                       (cons (make-string (+ base-spaces-per-gap
                                             (if (> current-extra-spaces 0) 1 0))
                                          #\space)
                             (build-string-parts (cdr words-list)
                                                 (if (> current-extra-spaces 0)
                                                     (- current-extra-spaces 1)
                                                     0)))))))
       (set! justified-string (string-join (build-string-parts words-on-line extra-spaces-left) "")))]
    (set! result (append result (list justified-string))))

  (for-each
   (lambda (word)
     (define word-len (length word))
     (define num-words-in-current-line (length current-line-words))

     (define potential-length
       (+ current-word-lengths-sum
          word-len
          (if (zero? num-words-in-current-line) 0 num-words-in-current-line)))

     (if (<= potential-length max-width)
         (begin
           (set! current-line-words (append current-line-words (list word)))
           (set! current-word-lengths-sum (+ current-word-lengths-sum word-len)))
         (begin
           (justify-and-add-line current-line-words current-word-lengths-sum #f)
           (set! current-line-words (list word))
           (set! current-word-lengths-sum word-len))))
   words)

  (justify-and-add-line current-line-words current-word-lengths-sum #t)

  result)