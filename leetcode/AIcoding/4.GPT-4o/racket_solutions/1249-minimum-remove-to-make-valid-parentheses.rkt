(define (min-remove-to-make-valid s)
  (define (is-valid s)
    (let loop ((s s) (balance 0))
      (cond
        ((null? s) (= balance 0))
        ((char=? (car s) #\() (loop (cdr s) (+ balance 1)))
        ((char=? (car s) #\)) (if (> balance 0) (loop (cdr s) (- balance 1)) #f))
        (else (loop (cdr s) balance)))))

  (define (remove-invalid s)
    (let loop ((s s) (balance 0) (result '()))
      (cond
        ((null? s) (reverse result))
        ((char=? (car s) #\() (loop (cdr s) (+ balance 1) (cons (car s) result)))
        ((char=? (car s) #\)) (if (> balance 0) (loop (cdr s) (- balance 1) (cons (car s) result)) (loop (cdr s) balance result)))
        (else (loop (cdr s) balance (cons (car s) result)))))

  (define valid-string (remove-invalid s))
  (define (remove-extra s balance)
    (if (= balance 0) s
        (let loop ((s s) (result '()) (count 0))
          (cond
            ((null? s) (reverse result))
            ((char=? (car s) #\() (if (< count balance) (loop (cdr s) (cons (car s) result) (+ count 1)) (loop (cdr s) result count)))
            ((char=? (car s) #\)) (loop (cdr s) (cons (car s) result) count))
            (else (loop (cdr s) (cons (car s) result) count))))))

  (let ((left-count (length (filter (lambda (c) (char=? c #\() )) s)))
        (right-count (length (filter (lambda (c) (char=? c #\)) s))))
    (let-values (((valid-s) (remove-extra valid-string (max 0 (- left-count right-count)))))
      (list->string valid-s))))