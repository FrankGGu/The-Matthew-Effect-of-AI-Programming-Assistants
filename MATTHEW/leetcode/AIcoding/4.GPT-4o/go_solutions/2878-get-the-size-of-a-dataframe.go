package main

import (
	"fmt"
	"golang.org/x/exp/slices"
)

type DataFrame struct {
	data [][]int
}

func (df *DataFrame) Size() (int, int) {
	if len(df.data) == 0 {
		return 0, 0
	}
	return len(df.data), len(df.data[0])
}

func main() {
	df := &DataFrame{
		data: [][]int{{1, 2}, {3, 4}},
	}
	rows, cols := df.Size()
	fmt.Println(rows, cols)
}