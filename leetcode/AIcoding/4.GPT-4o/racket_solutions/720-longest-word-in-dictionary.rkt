(define (longest-word words)
  (let loop ((words (sort words string<?)) (result ""))
            (seen (make-hash)))
    (if (null? words)
        result
        (let* ((word (car words))
               (prefix (substring word 0 (- (string-length word) 1))))
          (if (or (string=? prefix "") (hash-has-key? seen prefix))
              (begin
                (hash-set! seen word #t)
                (loop (cdr words) (if (> (string-length word) (string-length result)) word result)))
              (loop (cdr words) result))))))

(define (find-longest-word words)
  (longest-word words))