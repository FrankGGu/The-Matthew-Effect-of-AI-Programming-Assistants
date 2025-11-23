(define InsertDeleteGetRandom
  (lambda ()
    (define data (hash))
    (define arr '())
    (define random (lambda () (if (null? arr) 0 (list-ref arr (random (length arr))))))

    (define insert
      (lambda (val)
        (unless (hash-has-key? data val)
          (hash-set! data val (length arr))
          (set! arr (append arr (list val))))))

    (define delete
      (lambda (val)
        (when (hash-has-key? data val)
          (let* ((index (hash-ref data val))
                 (last (last arr)))
            (hash-remove! data val)
            (if (not (= index (sub1 (length arr))))
                (begin
                  (set! arr (append (take arr index) (list last) (drop arr (add1 index))))
                  (hash-set! data last index))
                (set! arr (take arr index)))))))

    (define getRandom
      (lambda ()
        (random)))

    (lambda (operation . args)
      (cond
        ((equal? operation 'insert) (insert (car args)))
        ((equal? operation 'delete) (delete (car args)))
        ((equal? operation 'getRandom) (getRandom))))))