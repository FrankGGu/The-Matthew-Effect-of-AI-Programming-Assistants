import (
	"sort"
)

func miceAndCheese(reward1 []int, reward2 []int, k int) int {
	n := len(reward1)
	diffs := make([]int, n)
	for i := 0; i < n; i++ {
		diffs[i] = reward1[i] - reward2[i]
	}

	indices := make([]int, n)
	for i := 0; i < n; i++ {
		indices[i] = i
	}

	sort.Slice(indices, func(i, j int) bool {
		return diffs[indices[i]] > diffs[indices[j]]
	})

	totalReward := 0
	for i := 0; i < k; i++ {
		totalReward += reward1[indices[i]]
	}
	for i := k; i < n; i++ {
		totalReward += reward2[indices[i]]
	}

	return totalReward
}