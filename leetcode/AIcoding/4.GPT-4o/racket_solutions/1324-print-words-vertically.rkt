(define (print-vertically s)
  (define words (string-split s))
  (define max-length (apply max (map string-length words)))
  (define result '())
  (for ((i (in-range max-length)))
    (define line (map (lambda (word) 
                        (if (< (string-length word) (+ i 1)) 
                            " " 
                            (string-ref word i))) 
                      words))
    (set! result (cons (string-join line "") result)))
  (string-join (reverse result) "\n"))

(define (main)
  (print-vertically "HOW ARE YOU")) ; Example usage, replace with input as needed