import "fmt"

func pivotTable(df [][]interface{}) [][]interface{} {
	headerMap := make(map[interface{}]int)
	valueMap := make(map[interface{}]map[interface{}]interface{})
	headerIndex := 0

	for i := 1; i < len(df); i++ {
		pivotKey := df[i][0]
		headerKey := df[i][1]
		value := df[i][2]

		if _, ok := headerMap[headerKey]; !ok {
			headerMap[headerKey] = headerIndex
			headerIndex++
		}

		if _, ok := valueMap[pivotKey]; !ok {
			valueMap[pivotKey] = make(map[interface{}]interface{})
		}

		valueMap[pivotKey][headerKey] = value
	}

	headerRow := []interface{}{"pivot_col"}
	headerList := make([]interface{}, len(headerMap))
	headerIndexMap := make(map[int]interface{})
	index := 0
	for header, i := range headerMap {
		headerList[i] = header
		headerIndexMap[i] = header
		index++
	}

	sort.Slice(headerList, func(i, j int) bool {
		return fmt.Sprintf("%v", headerList[i]) < fmt.Sprintf("%v", headerList[j])
	})

	for _, header := range headerList {
		headerRow = append(headerRow, header)
	}

	result := [][]interface{}{headerRow}

	pivotKeys := make([]interface{}, 0, len(valueMap))
	for key := range valueMap {
		pivotKeys = append(pivotKeys, key)
	}
	sort.Slice(pivotKeys, func(i, j int) bool {
		return fmt.Sprintf("%v", pivotKeys[i]) < fmt.Sprintf("%v", pivotKeys[j])
	})

	for _, pivotKey := range pivotKeys {
		row := []interface{}{pivotKey}
		for _, header := range headerList {
			if val, ok := valueMap[pivotKey][header]; ok {
				row = append(row, val)
			} else {
				row = append(row, nil)
			}
		}
		result = append(result, row)
	}

	return result
}

import "sort"