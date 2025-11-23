package main

import (
	"fmt"
	"sort"
)

func largestGoodInteger(num string) string {
	count := make(map[string]int)
	for i := 0; i < len(num)-2; i++ {
		if num[i] == num[i+1] && num[i] == num[i+2] {
			count[string(num[i])]++
		}
	}
	var result string
	for k := range count {
		if result < k+k+k {
			result = k + k + k
		}
	}
	return result
}

func main() {
	fmt.Println(largestGoodInteger("6777133339")) // Output: "777"
}