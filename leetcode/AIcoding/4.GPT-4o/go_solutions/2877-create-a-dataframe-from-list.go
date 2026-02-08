package main

import (
	"fmt"
	"reflect"
)

type DataFrame struct {
	Data [][]interface{}
}

func CreateDataFrame(data [][]interface{}) DataFrame {
	return DataFrame{Data: data}
}

func main() {
	data := [][]interface{}{
		{"A", 1},
		{"B", 2},
		{"C", 3},
	}
	df := CreateDataFrame(data)
	fmt.Println(reflect.DeepEqual(df.Data, data)) // Just for testing purpose
}