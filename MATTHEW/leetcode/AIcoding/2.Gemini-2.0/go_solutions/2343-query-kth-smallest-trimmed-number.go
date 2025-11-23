import "sort"

func smallestTrimmedNumbers(nums []string, queries [][]int) []int {
	n := len(nums)
	m := len(queries)
	res := make([]int, m)

	for i := 0; i < m; i++ {
		k := queries[i][0]
		trim := queries[i][1]

		type Pair struct {
			Trimmed string
			Index   int
		}

		trimmedNums := make([]Pair, n)
		for j := 0; j < n; j++ {
			num := nums[j]
			l := len(num)
			trimmedNums[j] = Pair{Trimmed: num[l-trim:], Index: j}
		}

		sort.Slice(trimmedNums, func(a, b int) bool {
			if trimmedNums[a].Trimmed != trimmedNums[b].Trimmed {
				return trimmedNums[a].Trimmed < trimmedNums[b].Trimmed
			}
			return a < b
		})

		res[i] = trimmedNums[k-1].Index
	}

	return res
}