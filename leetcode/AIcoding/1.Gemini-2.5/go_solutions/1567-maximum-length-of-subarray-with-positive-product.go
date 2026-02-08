package main

import "math"

func getMaxLength(nums []int) int {
	maxLength := 0
	positiveLength := 0 // Length of the current subarray ending with a positive product
	negativeLength := 0 // Length of the current subarray ending with a negative product

	for _, num := range nums {
		if num == 0 {
			// A zero resets any product.
			// The subarray must not contain zero.
			positiveLength = 0
			negativeLength = 0
		} else if num > 0 {
			// If the current number is positive:
			// A positive product remains positive and extends.
			positiveLength = positiveLength + 1
			// A negative product multiplied by a positive number remains negative and extends, if it existed.
			if negativeLength > 0 {
				negativeLength = negativeLength + 1
			} else {
				// If there was no negative product, multiplying by a positive number won't create one.
				negativeLength = 0
			}
		} else { // num < 0
			// If the current number is negative:
			// Store current lengths before updating, as new positiveLength depends on old negativeLength
			// and new negativeLength depends on old positiveLength.
			prevPositiveLength := positiveLength
			prevNegativeLength := negativeLength

			// A negative product multiplied by a negative number becomes positive.
			if prevNegativeLength > 0 {
				positiveLength = prevNegativeLength + 1
			} else {
				// If there was no previous negative product, multiplying by a negative number won't make it positive.
				positiveLength = 0
			}

			// A positive product multiplied by a negative number becomes negative.
			negativeLength = prevPositiveLength + 1
		}
		// Update the maximum length found so far.
		// We only care about subarrays with positive products.
		maxLength = int(math.Max(float64(maxLength), float64(positiveLength)))
	}

	return maxLength
}