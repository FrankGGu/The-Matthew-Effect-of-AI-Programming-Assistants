(define (num-special-equivalent-groups A)
  (define (special-eq-group str)
    (define even (string->list (substring str 0 (string-length str))))
    (define odd (string->list (substring str 1 (string-length str))))
    (define (count-char lst)
      (foldl (lambda (c acc)
                (hash-set acc c (add1 (hash-ref acc c 0))))
              (make-hash) lst))
    (list (hash->list (count-char even)) (hash->list (count-char odd))))

  (define (group-keys groups)
    (define (key-fn lst)
      (map (lambda (x) (sort x char<?)) lst))
    (set (map key-fn groups)))

  (define groups (map special-eq-group A))
  (set-count (group-keys groups)))

(define (main)
  (define A '("abcd" "cdab" "cbad" "xyzz" "zzxy" "zzyx"))
  (display (num-special-equivalent-groups A)))

(main)