package main

import (
	"strconv"
)

func reverse(num int64) int64 {
	var res int64
	for num > 0 {
		res = res*10 + num%10
		num /= 10
	}
	return res
}

func largestPalindrome(n int) int {
	if n == 1 {
		return 9
	}

	// maxNum is the largest n-digit number (e.g., 99 for n=2)
	var maxNum int64 = 1
	for i := 0; i < n; i++ {
		maxNum *= 10
	}
	maxNum--

	// minNum is the smallest n-digit number (e.g., 10 for n=2)
	var minNum int64 = 1
	for i := 0; i < n-1; i++ {
		minNum *= 10
	}

	// powerOf10 is 10^n (e.g., 100 for n=2)
	// Used to construct the palindrome: leftHalf * 10^n + reverse(leftHalf)
	powerOf10 := maxNum + 1

	// Iterate downwards from maxNum for the first half of the palindrome.
	// The largest palindrome will be a 2n-digit number.
	// It's formed by 'leftHalf' and 'reverse(leftHalf)'.
	for leftHalf := maxNum; leftHalf >= minNum; leftHalf-- {
		// Construct the palindrome
		palindrome := leftHalf*powerOf10 + reverse(leftHalf)

		// Check for factors x and y such that palindrome = x * y
		// Both x and y must be n-digit numbers (i.e., between minNum and maxNum).
		// We iterate x downwards from maxNum.
		// The other factor y = palindrome / x.
		// We need y >= minNum and y <= maxNum.
		// The condition y <= maxNum implies palindrome / x <= maxNum, so x >= palindrome / maxNum.
		// The condition y >= minNum implies palindrome / x >= minNum, so x <= palindrome / minNum.
		// So x should iterate from maxNum down to max(minNum, palindrome / maxNum).
		for x := maxNum; x >= minNum; x-- {
			// Optimization: if x is too small, then y = palindrome / x will be too large (not an n-digit number).
			// This happens when x < palindrome / maxNum.
			if x < palindrome/maxNum {
				break
			}

			if palindrome%x == 0 {
				y := palindrome / x
				// x is already checked to be >= minNum.
				// y is implicitly checked to be <= maxNum by the `x < palindrome / maxNum` break condition.
				// We only need to explicitly check y >= minNum.
				if y >= minNum {
					return int(palindrome % 1337)
				}
			}
		}
	}
	return 0 // Should not be reached for valid inputs given problem constraints
}