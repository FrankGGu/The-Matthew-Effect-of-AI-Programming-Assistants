package main

import (
	"reflect"
)

func get_size(df interface{}) []int {
	r := reflect.ValueOf(df)
	if r.Kind() != reflect.Slice {
		return []int{0, 0}
	}
	rows := r.Len()
	if rows == 0 {
		return []int{0, 0}
	}
	col := reflect.ValueOf(r.Index(0).Interface()).Len()
	return []int{rows, col}
}