package main

import (
	"fmt"
	"sort"
	"strconv"
)

func minNumber(nums1 []int, nums2 []int) string {
	seen := make(map[int]bool)
	for _, num := range nums1 {
		seen[num] = true
	}

	var common []int
	for _, num := range nums2 {
		if seen[num] {
			common = append(common, num)
		}
	}

	if len(common) > 0 {
		sort.Ints(common)
		return strconv.Itoa(common[0])
	}

	sort.Ints(nums1)
	sort.Ints(nums2)

	return minStr(strconv.Itoa(nums1[0]), strconv.Itoa(nums2[0]))
}

func minStr(num1, num2 string) string {
	if num1+num2 < num2+num1 {
		return num1 + num2
	}
	return num2 + num1
}

func main() {
	fmt.Println(minNumber([]int{1, 2, 3}, []int{3, 4, 5}))
	fmt.Println(minNumber([]int{3, 5, 2}, []int{5, 7, 1}))
}