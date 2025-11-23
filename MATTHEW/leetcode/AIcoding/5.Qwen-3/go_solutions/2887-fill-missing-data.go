package main

func fillMissingData(products []map[string]interface{}) []map[string]interface{} {
	for i := 0; i < len(products); i++ {
		if val, ok := products[i]["quantity"].(int); ok && val == 0 {
			products[i]["quantity"] = 10
		}
	}
	return products
}