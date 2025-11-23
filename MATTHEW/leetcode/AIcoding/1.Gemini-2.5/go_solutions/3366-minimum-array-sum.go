import (
	"sort"
)

func minIncrementForUnique(nums []int) int {
	sort.Ints(nums)

	increments := 0
	expectedNum := 0 // The smallest number we expect for the current position

	for _, num := range nums {
		if num < expectedNum {
			// If the current number is less than what's expected,
			// we must increment it to expectedNum.
			increments += (expectedNum - num)
		} else {
			// If the current number is already greater than or equal to expectedNum,
			// it's fine as is (or already unique).
			// We update expectedNum to be num itself.
			expectedNum = num
		}
		// For the next number, we must ensure it's at least expectedNum + 1.
		expectedNum++
	}

	return increments
}