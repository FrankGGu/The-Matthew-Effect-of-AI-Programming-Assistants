package main

import (
	"fmt"
)

func longestDupSubstring(S string) string {
	n := len(S)
	if n == 0 {
		return ""
	}

	base := 256
	mod := 1_000_000_007

	power := make([]int, n)
	power[0] = 1
	for i := 1; i < n; i++ {
		power[i] = (power[i-1] * base) % mod
	}

	hash := make([]int, n)
	hash[0] = int(S[0])
	for i := 1; i < n; i++ {
		hash[i] = (hash[i-1]*base + int(S[i])) % mod
	}

	check := func(length int) string {
		seen := make(map[int]struct{})
		for i := 0; i <= n-length; i++ {
			if i == 0 {
				hashValue := hash[length-1]
				if _, ok := seen[hashValue]; ok {
					return S[i : i+length]
				}
				seen[hashValue] = struct{}{}
			} else {
				hashValue := (hash[i+length-1] - hash[i-1]*power[length] % mod + mod) % mod
				if _, ok := seen[hashValue]; ok {
					return S[i : i+length]
				}
				seen[hashValue] = struct{}{}
			}
		}
		return ""
	}

	left, right := 1, n-1
	result := ""
	for left <= right {
		mid := left + (right-left)/2
		if sub := check(mid); sub != "" {
			result = sub
			left = mid + 1
		} else {
			right = mid - 1
		}
	}

	return result
}

func main() {
	S := "banana"
	fmt.Println(longestDupSubstring(S))
}