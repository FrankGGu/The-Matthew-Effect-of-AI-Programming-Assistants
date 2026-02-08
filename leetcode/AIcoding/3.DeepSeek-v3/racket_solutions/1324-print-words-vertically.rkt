(define/contract (print-words-vertically s)
  (-> string? (listof string?))
  (let* ((words (string-split s))
         (max-len (apply max (map string-length words)))
         (padded-words (map (lambda (w) (string-append w (make-string (- max-len (string-length w)) #\ )))) words)))
    (for/list ([i (in-range max-len)])
      (string-trim-right 
       (apply string 
              (for/list ([word padded-words])
                (string-ref word i)))
      #\ ))))