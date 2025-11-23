(define/contract (crack-password password)
  (-> (listof char?) string?)
  (list->string (sort password char<?)))