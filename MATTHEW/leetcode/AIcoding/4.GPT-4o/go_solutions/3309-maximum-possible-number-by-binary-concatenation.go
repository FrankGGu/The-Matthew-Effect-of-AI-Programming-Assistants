package main

import (
	"fmt"
	"sort"
	"strconv"
)

func maximumNumber(nums []int) string {
	sort.Slice(nums, func(i, j int) bool {
		return strconv.Itoa(nums[i])+strconv.Itoa(nums[j]) > strconv.Itoa(nums[j])+strconv.Itoa(nums[i])
	})
	result := ""
	for _, num := range nums {
		result += strconv.Itoa(num)
	}
	return result
}

func main() {
	nums := []int{3, 30, 34, 5, 9}
	fmt.Println(maximumNumber(nums))
}