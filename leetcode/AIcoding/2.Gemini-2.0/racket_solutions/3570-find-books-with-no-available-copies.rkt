(define (find-books books copies)
  (let* ((book-counts (make-hash))
         (copy-counts (make-hash))
         (result '()))

    (for ([book (in-list books)])
      (hash-update! book-counts book (λ (x) (+ x 1)) 0))

    (for ([copy (in-list copies)])
      (hash-update! copy-counts (hash-ref copy 'book_id) (λ (x) (+ x 1)) 0))

    (for ([book (in-list books)])
      (let ([book-id (hash-ref book 'book_id)])
        (if (not (hash-has-key? copy-counts book-id))
            (set! result (cons book-id result))
            (if (< (hash-ref copy-counts book-id) (hash-ref book-counts book-id))
                '() ; Do nothing
                (set! result (cons book-id result))))))

    (sort (remove-duplicates result) <)))