func createNewColumn(arr []map[string]interface{}) []map[string]interface{} {
	for i := range arr {
		arr[i]["newCol"] = arr[i]["col1"].(int) + arr[i]["col2"].(int)
	}
	return arr
}