(define (select)
  (query 
    (select 
      (top 3)
      (from (select 1 as "RowID") 
            (select 2 as "RowID") 
            (select 3 as "RowID")))))