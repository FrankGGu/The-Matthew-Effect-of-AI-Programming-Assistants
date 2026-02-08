import "sort"

func sortByBits(arr []int) []int {
	countBits := func(x int) int {
		count := 0
		for x > 0 {
			count += x & 1
			x >>= 1
		}
		return count
	}

	sort.Slice(arr, func(i, j int) bool {
		bitCountI := countBits(arr[i])
		bitCountJ := countBits(arr[j])
		if bitCountI == bitCountJ {
			return arr[i] < arr[j]
		}
		return bitCountI < bitCountJ
	})

	return arr
}