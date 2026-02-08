(define/contract (expect-number scores)
  (-> (listof exact-integer?) exact-integer?)
  (set-count (list->set scores)))