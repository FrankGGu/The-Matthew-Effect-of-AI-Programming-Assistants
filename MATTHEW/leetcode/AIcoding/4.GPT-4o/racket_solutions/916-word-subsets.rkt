(define (word-subsets A B)
  (define (count-letters word)
    (foldl (lambda (char acc)
             (hash-update acc char (lambda (x) (+ x 1)) 0))
           (make-hash)
           word))

  (define b-counts
    (foldl (lambda (b acc)
             (for/fold ([a acc])
               ([i (in-range 26)])
               (let ([char (integer->char (+ i (char->integer #\a)))])
                 (hash-update a char (lambda (x) (max x (hash-ref (count-letters b) char 0))) 0))))
           (make-hash)
           B))

  (define (is-universal word)
    (define a-count (count-letters word))
    (for/and ([char (hash-keys b-counts)])
      (<= (hash-ref a-count char 0) (hash-ref b-counts char 0))))

  (filter is-universal A))