func maximumSegmentSum(nums []int, removeQueries []int) []int64 {
	n := len(nums)
	parent := make([]int, n)
	size := make([]int64, n)
	sum := make([]int64, n)
	ans := make([]int64, len(removeQueries))
	maxSum := int64(0)

	for i := 0; i < n; i++ {
		parent[i] = i
		size[i] = 1
		sum[i] = int64(nums[i])
	}

	find := func(x int) int {
		if parent[x] != x {
			parent[x] = find(parent[x])
		}
		return parent[x]
	}

	union := func(x, y int) {
		rootX := find(x)
		rootY := find(y)
		if rootX != rootY {
			if size[rootX] < size[rootY] {
				rootX, rootY = rootY, rootX
			}
			parent[rootY] = rootX
			size[rootX] += size[rootY]
			sum[rootX] += sum[rootY]
			if sum[rootX] > maxSum {
				maxSum = sum[rootX]
			}
		}
	}

	visited := make([]bool, n)
	for i := len(removeQueries) - 1; i >= 0; i-- {
		ans[i] = maxSum
		idx := removeQueries[i]
		visited[idx] = true

		if idx > 0 && visited[idx-1] {
			union(idx-1, idx)
		}
		if idx < n-1 && visited[idx+1] {
			union(idx, idx+1)
		}
		if !visited[idx-1] && !visited[idx+1] {
			maxSum = max(maxSum, 0)
		}

	}

	return ans
}

func max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}