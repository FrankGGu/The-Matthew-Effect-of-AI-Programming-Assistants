(define (melt data column_name variable_name value_name)
  (let* ([id_vars (vector->list (vector-remove data column_name))]
         [value_vars (list (vector-ref data column_name))]
         [num_rows (table-nrow data)]
         [num_id_vars (length id_vars)]
         [num_value_vars (length value_vars)]
         [result (make-table (list variable_name value_name) 0))]
    (for ([i (in-range num_rows)])
      (for ([j (in-range num_value_vars)])
        (let ([row (vector->list (table-row data i))])
          (let ([id_values (list->vector (remove row (vector->list (vector column_name))))]
                [value (list (vector-ref (vector->list (vector column_name)) 0))])
            (table-push! result (list (list-ref value_vars 0) (list-ref row (vector-ref (vector column_name) 0))))))))
    result))