(define (reverseKGroup head k)
  (define (reverse-list lst)
    (define (rev acc lst)
      (if (null? lst)
          acc
          (rev (cons (car lst) acc) (cdr lst))))
    (rev '() lst))

  (define (helper head)
    (define count 0)
    (define current head)
    (while (and current (< count k))
      (set! current (cdr current))
      (set! count (+ count 1)))
    (if (< count k)
        head
        (begin
          (set! current head)
          (define reversed (reverse-list (take head k)))
          (set! head (cdr (drop head k)))
          (for-each (lambda (node)
                      (set-cdr! node (if (null? head) '() head)))
                    reversed)
          (set-cdr! (last reversed) head)
          reversed)))

  (helper head))