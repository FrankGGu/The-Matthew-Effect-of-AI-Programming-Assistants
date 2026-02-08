import "sort"

func transformArray(arr []int) []int {
	n := len(arr)
	if n <= 2 {
		return arr
	}

	prev := make([]int, n)
	copy(prev, arr)

	for {
		curr := make([]int, n)
		copy(curr, prev)
		changed := false

		for i := 1; i < n-1; i++ {
			if prev[i-1] > prev[i] && prev[i+1] > prev[i] {
				curr[i]++
				changed = true
			} else if prev[i-1] < prev[i] && prev[i+1] < prev[i] {
				curr[i]--
				changed = true
			}
		}

		if !changed {
			return curr
		}

		prev = curr
	}
}