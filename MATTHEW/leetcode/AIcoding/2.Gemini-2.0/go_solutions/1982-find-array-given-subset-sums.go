import (
	"sort"
)

func recoverArray(n int, sums []int) []int {
	sort.Ints(sums)
	res := make([]int, 0, n)
	for i := 0; i < n; i++ {
		diff := sums[1] - sums[0]
		pos, neg := []int{}, []int{}
		count := 0
		used := make(map[int]bool)
		for _, sum := range sums {
			if used[sum] {
				continue
			}
			pos = append(pos, sum)
			neg = append(neg, sum+diff)
			used[sum+diff] = true
			count++
		}
		if contains(pos, 0) {
			res = append(res, diff)
			sums = pos
		} else {
			res = append(res, -diff)
			sums = neg[:count]
		}
	}
	return res
}

func contains(arr []int, target int) bool {
	for _, num := range arr {
		if num == target {
			return true
		}
	}
	return false
}