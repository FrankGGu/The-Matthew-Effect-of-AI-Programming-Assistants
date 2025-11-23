(define (alphabet-board-path target)
  (define (char-to-coords c)
    (if (char=? c #\z)
        (list 5 0)
        (let* ((val (- (char->integer c) (char->integer #\a)))
               (row (quotient val 5))
               (col (remainder val 5)))
          (list row col))))

  (define current-row 0)
  (define current-col 0)
  (define result '())

  (for-each
   (lambda (target-char)
     (let* ((target-coords (char-to-coords target-char))
            (tr (list-ref target-coords 0))
            (tc (list-ref target-coords 1))
            (dr (- tr current-row))
            (dc (- tc current-col)))

       (cond
         ((and (= tr 5) (= tc 0)) ; Moving TO 'z' (prioritize horizontal then vertical)
          (when (< dc 0) (set! result (append result (make-list (- dc) #\L))))
          (when (> dc 0) (set! result (append result (make-list dc #\R))))
          (when (< dr 0) (set! result (append result (make-list (- dr) #\U))))
          (when (> dr 0) (set! result (append result (make-list dr #\D)))))

         ((and (= current-row 5) (= current-col 0)) ; Moving FROM 'z' (prioritize vertical then horizontal)
          (when (< dr 0) (set! result (append result (make-list (- dr) #\U))))
          (when (> dr 0) (set! result (append result (make-list dr #\D))))
          (when (< dc 0) (set! result (append result (make-list (- dc) #\L))))
          (when (> dc 0) (set! result (append result (make-list dc #\R)))))

         (else ; All other moves (vertical then horizontal)
          (when (< dr 0) (set! result (append result (make-list (- dr) #\U))))
          (when (> dr 0) (set! result (append result (make-list dr #\D))))
          (when (< dc 0) (set! result (append result (make-list (- dc) #\L))))
          (when (> dc 0) (set! result (append result (make-list dc #\R))))))

       (set! result (append result (list #\!)))
       (set! current-row tr)
       (set! current-col tc)))
   (string->list target))

  (list->string result))