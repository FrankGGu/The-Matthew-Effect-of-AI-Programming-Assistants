import "fmt"

func countOfPairs(n int, x int, y int) []int {
	ans := make([]int, n+1)

	// Ensure x < y for consistent logic
	if x > y {
		x, y = y, x
	}

	for i := 1;