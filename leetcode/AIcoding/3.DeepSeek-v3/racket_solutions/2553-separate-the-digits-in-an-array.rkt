(define/contract (separate-digits nums)
  (-> (listof exact-integer?) (listof exact-integer?))
  (flatten (map (lambda (num) (map (lambda (c) (- (char->integer c) 48)) (string->list (number->string num)))) nums))