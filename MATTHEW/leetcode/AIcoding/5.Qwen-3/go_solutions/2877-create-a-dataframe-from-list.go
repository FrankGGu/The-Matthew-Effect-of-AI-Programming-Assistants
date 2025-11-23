package main

import (
	"sort"
)

type DataFrame struct {
	data []map[string]interface{}
}

func createDataFrame(animals [][]interface{}) *DataFrame {
	df := &DataFrame{}
	for _, row := range animals {
		if len(row) != 3 {
			continue
		}
		df.data = append(df.data, map[string]interface{}{
			"name":   row[0],
			"type":   row[1],
			"age":    row[2],
		})
	}
	return df
}

func (df *DataFrame) sortDataFrame() {
	sort.Slice(df.data, func(i, j int) bool {
		return df.data[i]["name"].(string) < df.data[j]["name"].(string)
	})
}