(define (full-justify words max-width)
  (letrec (
    (justify-line (words width)
      (cond
        [(null? words) ""]
        [(null? (cdr words)) (string-append (string-join words " ") (make-string (- max-width width) #\space))]
        [else
          (let* ((num-words (length words))
                 (num-spaces (- max-width width))
                 (base-space (quotient num-spaces (- num-words 1)))
                 (extra-space (remainder num-spaces (- num-words 1)))
                 (spaces (map (lambda (i) (string-append (make-string (+ base-space (if (< i extra-space) 1 0)) #\space) )) (range 0 (- num-words 1))))
                 (result (string-join (append (list (car words)) (flatten (map list (cdr words) spaces))) "")))
            result)])))

    (justify-last-line (words)
      (string-append (string-join words " ") (make-string (- max-width (string-length (string-join words " "))) #\space)))

    (helper (words result current-line current-width)
      (cond
        [(null? words)
         (if (null? current-line)
             result
             (append result (list (justify-last-line current-line))))]
        [else
          (let ((word (car words))
                (rest (cdr words))
                (word-length (string-length word)))
            (cond
              [(> (+ current-width (if (null? current-line) 0 1) word-length) max-width)
               (helper rest (append result (list (justify-line current-line current-width))) (list word) word-length)]
              [else
               (helper rest result (append current-line (list word)) (+ current-width (if (null? current-line) 0 1) word-length))]))])))

  (helper words '() '() 0))