(define (is-unival-tree root)
  (if (null? root)
      #t
      (let ((val (car root)))
        (define (helper node val)
          (if (null? node)
              #t
              (and (= (car node) val)
                   (helper (cadr node) val)
                   (helper (caddr node) val))))
        (helper root val))))