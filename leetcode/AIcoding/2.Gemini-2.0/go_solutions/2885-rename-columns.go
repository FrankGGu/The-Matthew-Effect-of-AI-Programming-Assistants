import "strings"

func renameColumns(df map[string][]interface{}, columnMap map[string]string) map[string][]interface{} {
	newDf := make(map[string][]interface{})
	for oldName, values := range df {
		newName, ok := columnMap[oldName]
		if !ok {
			newName = oldName
		}
		newDf[newName] = values
	}
	return newDf
}

func interfaceSliceToStringSlice(interfaceSlice []interface{}) []string {
	stringSlice := make([]string, len(interfaceSlice))
	for i, v := range interfaceSlice {
		stringSlice[i] = interfaceToString(v)
	}
	return stringSlice
}

func interfaceToString(value interface{}) string {
	switch v := value.(type) {
	case string:
		return v
	case int:
		return string(rune(v)) // Avoids issues with rune conversion
	case float64:
		return string(rune(int(v))) // Avoids issues with rune conversion
	default:
		return "" // Handle other types as needed
	}
}