package main

import (
	"sort"
)

func pivotTable(data [][]string) [][]string {
	if len(data) < 2 {
		return [][]string{}
	}

	headerRow := data[0]
	dataRows := data[1:]

	groupColName := "product_id"
	pivotColName := "store_id"
	valueColName := "price"

	groupColIdx := -1
	pivotColIdx := -1
	valueColIdx := -1

	for i, colName := range headerRow {
		if colName == groupColName {
			groupColIdx = i
		} else if colName == pivotColName {
			pivotColIdx = i
		} else if colName == valueColName {
			valueColIdx = i
		}
	}

	if groupColIdx == -1 || pivotColIdx == -1 || valueColIdx == -1 {
		return [][]string{}
	}

	pivotedData := make(map[string]map[string]string)
	uniqueGroupKeysMap := make(map[string]bool)
	uniquePivotKeysMap := make(map[string]bool)

	for _, row := range dataRows {
		groupKey := row[groupColIdx]
		pivotKey := row[pivotColIdx]
		value := row[valueColIdx]

		if _, ok := pivotedData[groupKey]; !ok {
			pivotedData[groupKey] = make(map[string]string)
		}
		pivotedData[groupKey][pivotKey] = value

		uniqueGroupKeysMap[groupKey] = true
		uniquePivotKeysMap[pivotKey] = true
	}

	var sortedGroupKeys []string
	for k := range uniqueGroupKeysMap {
		sortedGroupKeys = append(sortedGroupKeys, k)
	}
	sort.Strings(sortedGroupKeys)

	var sortedPivotKeys []string
	for k := range uniquePivotKeysMap {
		sortedPivotKeys = append(sortedPivotKeys, k)
	}
	sort.Strings(sortedPivotKeys)

	numRows := len(sortedGroupKeys) + 1
	numCols := len(sortedPivotKeys) + 1
	result := make([][]string, numRows)

	outputHeader := make([]string, numCols)
	outputHeader[0] = groupColName
	for i, pKey := range sortedPivotKeys {
		outputHeader[i+1] = pKey
	}
	result[0] = outputHeader

	for r, gKey := range sortedGroupKeys {
		row := make([]string, numCols)
		row[0] = gKey
		for c, pKey := range sortedPivotKeys {
			if val, ok := pivotedData[gKey][pKey]; ok {
				row[c+1] = val
			} else {
				row[c+1] = ""
			}
		}
		result[r+1] = row
	}

	return result
}