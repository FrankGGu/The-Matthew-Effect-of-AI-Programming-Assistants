package main

import (
	"fmt"
	"sort"
	"strconv"
)

func largestTimeFromDigits(A []int) string {
	sort.Sort(sort.Reverse(sort.IntSlice(A)))
	for i := 0; i < 24; i++ {
		h := i / 10
		m := i % 60
		h1, h2 := h/10, h%10
		m1, m2 := m/10, m%10
		if containsDigits(A, []int{h1, h2, m1, m2}) {
			return fmt.Sprintf("%02d:%02d", h, m)
		}
	}
	return ""
}

func containsDigits(A []int, B []int) bool {
	countA := make(map[int]int)
	countB := make(map[int]int)
	for _, num := range A {
		countA[num]++
	}
	for _, num := range B {
		countB[num]++
	}
	for num, count := range countB {
		if countA[num] < count {
			return false
		}
	}
	return true
}

func main() {
	A := []int{1, 2, 3, 4}
	fmt.Println(largestTimeFromDigits(A))
}