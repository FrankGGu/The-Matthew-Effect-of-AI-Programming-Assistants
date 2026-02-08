package main

import (
	"fmt"
	"sort"
	"strconv"
)

func largestInteger(target int, arr []int) string {
	count := make([]int, 10)
	for _, num := range arr {
		count[num]++
	}

	var result []int
	for i := 9; i >= 0; i-- {
		for count[i] > 0 && target >= i {
			result = append(result, i)
			target -= i
			count[i]--
		}
	}

	if target > 0 {
		return ""
	}

	sort.Sort(sort.Reverse(sort.IntSlice(result)))
	res := ""
	for _, num := range result {
		res += strconv.Itoa(num)
	}

	return res
}

func main() {
	fmt.Println(largestInteger(5, []int{3, 4, 5})) // Example usage
}