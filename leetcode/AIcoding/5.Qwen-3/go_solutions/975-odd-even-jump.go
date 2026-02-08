package main

func oddEvenJumps(arr []int) int {
	n := len(arr)
	indices := make([]int, n)
	for i := range indices {
		indices[i] = i
	}

	sort.Slice(indices, func(i, j int) bool {
		if arr[indices[i]] != arr[indices[j]] {
			return arr[indices[i]] < arr[indices[j]]
		}
		return indices[i] < indices[j]
	})

	nextOdd := make([]int, n)
	nextEven := make([]int, n)

	for i := 0; i < n; i++ {
		nextOdd[i] = -1
		nextEven[i] = -1
	}

	for i := 0; i < n-1; i++ {
		for j := i + 1; j < n; j++ {
			if arr[indices[i]] < arr[indices[j]] {
				nextOdd[indices[i]] = indices[j]
				break
			}
		}
	}

	for i := 0; i < n-1; i++ {
		for j := i + 1; j < n; j++ {
			if arr[indices[i]] < arr[indices[j]] {
				nextEven[indices[i]] = indices[j]
				break
			}
		}
	}

	odd := make([]bool, n)
	even := make([]bool, n)
	odd[n-1] = true
	even[n-1] = true

	for i := n - 2; i >= 0; i-- {
		odd[i] = even[nextOdd[i]]
		even[i] = odd[nextEven[i]]
	}

	count := 0
	for _, b := range odd {
		if b {
			count++
		}
	}
	return count
}