(provide make-spreadsheet spreadsheet-set! spreadsheet-get)

(define (make-spreadsheet rows cols)
  (contract
   [rows natural?]
   [cols natural?]
   (-> spreadsheet?))
  (let ([data (make-vector (* rows cols) #f)]
        [num-rows rows]
        [num-cols cols])
    (struct spreadsheet (data rows cols) #:mutable)
    (make-spreadsheet-struct data num-rows num-cols)))

(define (spreadsheet-set! s row col val)
  (contract
   [s spreadsheet?]
   [row natural?]
   [col natural?]
   [val any?]
   (-> void?))
  (let ([idx (+ (* row (spreadsheet-cols s)) col)])
    (vector-set! (spreadsheet-data s) idx val)))

(define (spreadsheet-get s row col)
  (contract
   [s spreadsheet?]
   [row natural?]
   [col natural?]
   (-> any?))
  (let ([idx (+ (* row (spreadsheet-cols s)) col)])
    (vector-ref (spreadsheet-data s) idx)))