#lang racket

(define (delete-duplicate-folders paths)
  (define trie (make-hash))
  (define folder-count (make-hash))
  (define duplicates (mutable-set))

  (define (build-trie)
    (for ([path paths])
      (let loop ([node trie] [rest-path path])
        (if (null? rest-path)
            (hash-set! node '() #t)
            (let ([folder (car rest-path)])
              (unless (hash-has-key? node folder)
                (hash-set! node folder (make-hash)))
              (loop (hash-ref node folder) (cdr rest-path)))))))

  (define (serialize node)
    (let ([keys (sort (filter (lambda (k) (not (null? k))) (hash-keys node) string<?)])
      (if (null? keys)
          ""
          (string-join (map (lambda (k) (string-append k "(" (serialize (hash-ref node k)) ")")) keys) ""))))

  (define (mark-duplicates node)
    (let ([keys (sort (filter (lambda (k) (not (null? k))) (hash-keys node) string<?)])
          [serial (serialize node)])
      (unless (equal? serial "")
          (hash-update! folder-count serial (lambda (v) (+ v 1)) 0))
      (for ([key keys])
        (mark-duplicates (hash-ref node key)))))

  (define (prune node path-so-far)
    (let ([keys (sort (filter (lambda (k) (not (null? k))) (hash-keys node) string<?)])
      (for ([key keys])
        (let ([child (hash-ref node key)]
              [new-path (append path-so-far (list key))])
          (let ([child-serial (serialize child)])
            (if (or (equal? child-serial "") (< (hash-ref folder-count child-serial 0) 2))
                (prune child new-path)
                (set-add! duplicates new-path)))))))

  (build-trie)
  (mark-duplicates trie)
  (prune trie '())

  (define result '())
  (for ([path paths])
    (unless (for/or ([dup (in-set duplicates)]) (and (<= (length dup) (length path)) (equal? dup (take path (length dup)))))
      (set! result (cons path result)))
  (reverse result))