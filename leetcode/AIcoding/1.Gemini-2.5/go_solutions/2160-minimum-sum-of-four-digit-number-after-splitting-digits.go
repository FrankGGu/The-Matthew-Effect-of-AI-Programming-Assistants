import (
	"sort"
)

func minimumSum(num int) int {
	digits := make([]int, 4)
	for i := 0; i < 4; i++ {
		digits[i] = num % 10
		num /= 10
	}

	sort.Ints(digits)

	// To minimize the sum of two two-digit numbers formed by the four digits,
	// the two smallest digits should be placed in the tens positions,
	// and the two largest digits should be placed in the units positions.
	// Let the sorted digits be d0, d1, d2, d3.
	// The two numbers can be formed as (d0*10 + d2) and (d1*10 + d3).
	// Their sum will be (d0*10 + d2) + (d1*10 + d3)
	// which simplifies to 10*(d0 + d1) + (d2 + d3).
	return (digits[0]*10 + digits[2]) + (digits[1]*10 + digits[3])
}