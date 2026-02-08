import "sort"

func maxCoins(piles []int) int {
	sort.Ints(piles)
	n := len(piles)
	ans := 0
	for i := n - 2; i >= n/3; i -= 2 {
		ans += piles[i]
	}
	return ans
}