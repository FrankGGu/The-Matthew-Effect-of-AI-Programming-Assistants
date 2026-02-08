import "sort"

func maximumTotalReward(reward []int, k int) int {
	sort.Ints(reward)
	n := len(reward)
	res := 0
	for i := n - 1; i >= 0 && k > 0; i-- {
		res += reward[i]
		k--
	}
	return res
}