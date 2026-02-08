package main

func dropMissingData(students []map[string]interface{}) []map[string]interface{} {
	result := make([]map[string]interface{}, 0)
	for _, student := range students {
		if name, ok := student["name"].(string); ok && name != "" {
			result = append(result, student)
		}
	}
	return result
}