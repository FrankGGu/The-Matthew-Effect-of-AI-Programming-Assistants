package main

func salesPerson(sales_table []map[string]interface{}) []string {
    salesIds := make(map[int]bool)
    for _, row := range sales_table {
        if row["sale_id"] != nil {
            salesIds[row["sale_id"].(int)] = true
        }
    }

    result := []string{}
    for _, row := range sales_table {
        if row["customer_id"] != nil && row["sale_id"] == nil {
            result = append(result, row["customer_id"].(string))
        }
    }

    return result
}