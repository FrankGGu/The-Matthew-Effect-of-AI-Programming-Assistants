package main

import (
	"fmt"
	"math"
)

func isPalindrome(n int) bool {
	s := fmt.Sprint(n)
	for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
		if s[i] != s[j] {
			return false
		}
	}
	return true
}

func kBase(n, k int) int {
	if n == 0 {
		return 0
	}
	baseK := 0
	power := 1
	for n > 0 {
		baseK += (n % k) * power
		n /= k
		power *= 10
	}
	return baseK
}

func kMirror(k int, m int) int {
	count := 0
	sum := 0
	for i := 1; count < m; i++ {
		if isPalindrome(i) {
			baseK := kBase(i, k)
			if isPalindrome(baseK) {
				count++
				sum += i
			}
		}
	}
	return sum
}

func kMirrorNumbers(k int, m int) int {
	return kMirror(k, m)
}

func main() {
	k := 3
	m := 5
	fmt.Println(kMirrorNumbers(k, m))
}