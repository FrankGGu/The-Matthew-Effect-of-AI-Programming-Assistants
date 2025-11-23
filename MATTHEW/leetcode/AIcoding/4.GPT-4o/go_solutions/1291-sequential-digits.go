package main

import (
	"fmt"
	"sort"
)

func sequentialDigits(low int, high int) []int {
	sequences := []int{}
	for i := 1; i <= 9; i++ {
		num := i
		for j := i + 1; j <= 9; j++ {
			num = num*10 + j
			if num >= low && num <= high {
				sequences = append(sequences, num)
			}
			if num > high {
				break
			}
		}
	}
	sort.Ints(sequences)
	return sequences
}

func main() {
	low := 100
	high := 300
	fmt.Println(sequentialDigits(low, high))
}