(define/contract (select-data students)
  (-> (listof (listof any/c)) (listof (listof any/c)))
  (filter (lambda (student) (equal? (third student) "Mathematics")) students)