func kItemsWithMaximumSum(numOnes int, numZeros int, numNegOnes int, k int) int {
	sum := 0
	if k <= numOnes {
		sum = k
	} else {
		sum += numOnes
		k -= numOnes
		if k <= numZeros {
			// sum += 0 * k
			k -= k
		} else {
			k -= numZeros
			sum -= k
		}
	}
	return sum
}