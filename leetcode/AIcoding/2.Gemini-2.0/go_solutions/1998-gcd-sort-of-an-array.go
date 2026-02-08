import "sort"

func gcdSort(nums []int) bool {
	n := len(nums)
	mx := 0
	for _, x := range nums {
		if x > mx {
			mx = x
		}
	}
	parent := make([]int, mx+1)
	for i := 0; i <= mx; i++ {
		parent[i] = i
	}
	var find func(int) int
	find = func(x int) int {
		if parent[x] != x {
			parent[x] = find(parent[x])
		}
		return parent[x]
	}
	union := func(x, y int) {
		x = find(x)
		y = find(y)
		if x != y {
			parent[x] = y
		}
	}
	for _, x := range nums {
		for i := 2; i*i <= x; i++ {
			if x%i == 0 {
				union(x, i)
				for x%i == 0 {
					x /= i
				}
			}
		}
		if x > 1 {
			union(x, 1)
		}
	}
	sortedNums := make([]int, n)
	copy(sortedNums, nums)
	sort.Ints(sortedNums)
	for i := 0; i < n; i++ {
		if find(nums[i]) != find(sortedNums[i]) {
			return false
		}
	}
	return true
}