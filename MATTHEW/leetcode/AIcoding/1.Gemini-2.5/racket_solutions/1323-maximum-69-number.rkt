(define (maximum69Number num)
  (string->number (string-replace (number->string num) "6" "9" 1)))