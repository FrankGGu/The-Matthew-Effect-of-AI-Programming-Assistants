import (
	"sort"
)

func minOperations(s string) int {
	freq := make(map[rune]int)
	for _, r := range s {
		freq[r]++
	}

	counts := make([]int, 0, len(freq))
	for _, count := range freq {
		counts = append(counts, count)
	}

	sort.Sort(sort.Reverse(sort.IntSlice(counts)))

	n := len(counts)
	ans := len(s)

	for target := 1; target <= counts[0]; target++ {
		curr := 0
		for i := 0; i < n; i++ {
			if counts[i] > target {
				curr += counts[i] - target
			}
		}
		ans = min(ans, curr)
	}

	for i := 1; i < n; i++ {
		if counts[i-1] == counts[i] {
			continue
		}
		target := counts[i-1] - 1
		if target == 0 {
			break
		}
		curr := 0
		for j := 0; j < n; j++ {
			if counts[j] > target {
				curr += counts[j] - target
			}
		}
		ans = min(ans, curr)
	}

	return ans
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}