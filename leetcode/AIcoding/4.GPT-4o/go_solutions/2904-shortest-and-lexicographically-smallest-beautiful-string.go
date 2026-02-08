package main

import (
	"fmt"
)

func getSmallestString(n int, k int) string {
	res := make([]byte, n)
	k -= n
	for i := 0; i < n; i++ {
		if k > 25 {
			res[i] = 'z'
			k -= 25
		} else {
			res[i] = byte('a' + k)
			k = 0
		}
	}
	return string(res)
}

func main() {
	n, k := 3, 27
	fmt.Println(getSmallestString(n, k))
}