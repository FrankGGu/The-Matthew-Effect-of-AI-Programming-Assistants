import "sort"

func minIncrementForUnique(A []int) int {
	if len(A) <= 1 {
		return 0
	}

	sort.Ints(A)

	totalIncrements := 0
	for i := 1; i < len(A); i++ {
		if A[i] <= A[i-1] {
			increment := A[i-1] + 1 - A[i]
			totalIncrements += increment
			A[i] = A[i-1] + 1
		}
	}

	return totalIncrements
}