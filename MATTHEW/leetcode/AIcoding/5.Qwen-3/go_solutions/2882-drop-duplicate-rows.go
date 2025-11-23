package main

func dropDuplicateRows(employees []map[string]interface{}) []map[string]interface{} {
	seen := make(map[string]bool)
	result := []map[string]interface{}{}
	for _, row := range employees {
		key := ""
		for k, v := range row {
			key += k + ":" + fmt.Sprintf("%v", v) + ";"
		}
		if !seen[key] {
			seen[key] = true
			result = append(result, row)
		}
	}
	return result
}