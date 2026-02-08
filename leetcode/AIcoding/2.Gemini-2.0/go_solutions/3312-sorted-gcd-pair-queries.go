import (
	"sort"
)

func gcd(a, b int) int {
	for b != 0 {
		a, b = b, a%b
	}
	return a
}

func solve() {

}

func solveQueries(nums1 []int, nums2 []int, queries [][]int) []int {
	n := len(nums1)
	m := len(queries)
	pairs := make([][]int, 0)
	for i := 0; i < n; i++ {
		for j := i + 1; j < n; j++ {
			pairs = append(pairs, []int{i, j, gcd(nums1[i], nums1[j]) + gcd(nums2[i], nums2[j])})
		}
	}

	sort.Slice(pairs, func(i, j int) bool {
		return pairs[i][2] < pairs[j][2]
	})

	ans := make([]int, m)
	for i := 0; i < m; i++ {
		k := queries[i][0]
		count := 0
		for _, pair := range pairs {
			if pair[2] <= k {
				count++
			} else {
				break
			}
		}
		ans[i] = count
	}

	return ans
}