package main

func addNegabinary(arr1 []int, arr2 []int) []int {
	res := []int{}
	carry := 0

	i := len(arr1) - 1
	j := len(arr2) - 1

	for i >= 0 || j >= 0 || carry != 0 {
		d1 := 0
		if i >= 0 {
			d1 = arr1[i]
			i--
		}

		d2 := 0
		if j >= 0 {
			d2 = arr2[j]
			j--
		}

		currentSum := d1 + d2 + carry

		// In negabinary (base -2), the digit is currentSum % 2
		// If currentSum is negative, we need to adjust for Go's % operator behavior.
		// For example, -1 % 2 is -1. We want 1.
		// The bitwise AND with 1 (currentSum & 1) correctly gives 0 for even numbers
		// and 1 for odd numbers, regardless of sign, for two's complement representation.
		digit := currentSum & 1

		// The new carry is (currentSum - digit) / (-2)
		// This comes from the relation: currentSum = digit + carry_out * (-2)
		carry = (currentSum - digit) / (-2)

		res = append(res, digit)
	}

	// The result is built in reverse order, so reverse it
	for k := 0; k < len(res)/2; k++ {
		res[k], res[len(res)-1-k] = res[len(res)-1-k], res[k]
	}

	// Remove leading zeros, unless the result is just [0]
	leadingZeroes := 0
	for leadingZeroes < len(res)-1 && res[leadingZeroes] == 0 {
		leadingZeroes++
	}

	return res[leadingZeroes:]
}