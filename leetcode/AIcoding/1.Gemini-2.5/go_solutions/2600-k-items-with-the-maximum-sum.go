func kItemsWithMaximumSum(numOnes int, numZeros int, numNegOnes int, k int) int {
	ans := 0

	// Prioritize picking items with value 1
	if k <= numOnes {
		ans += k
		k = 0 // All k items picked are 1s
	} else {
		ans += numOnes // Pick all available 1s
		k -= numOnes   // Reduce k by the number of 1s picked
	}

	if k == 0 {
		return ans
	}

	// Prioritize picking items with value 0
	// These items do not change the sum, but they consume k
	if k <= numZeros {
		k = 0 // All remaining k items picked are 0s
	} else {
		k -= numZeros // Reduce k by the number of 0s picked
	}

	if k == 0 {
		return ans
	}

	// Finally, pick items with value -1
	// At this point, k represents the number of -1s we must pick
	ans -= k // Each remaining item picked is a -1, so subtract k from sum
	// k = 0 // All k items picked are -1s

	return ans
}