package main

type Node struct {
	ones  int
	zeros int
	lazy  bool // true if this range needs to be flipped
}

func build(arr []int, tree []Node, nodeIdx, start, end int) {
	if start == end {
		if arr[start] == 1 {
			tree[nodeIdx] = Node{ones: 1, zeros: 0, lazy: false}
		} else {
			tree[nodeIdx] = Node{ones: 0, zeros: 1, lazy: false}
		}
		return
	}
	mid := (start + end) / 2
	build(arr, tree, 2*nodeIdx, start, mid)
	build(arr, tree, 2*nodeIdx+1, mid+1, end)
	tree[nodeIdx].ones = tree[2*nodeIdx].ones + tree[2*nodeIdx+1].ones
	tree[nodeIdx].zeros = tree[2*nodeIdx].zeros + tree[2*nodeIdx+1].zeros
}

func pushDown(tree []Node, nodeIdx int) {
	if tree[nodeIdx].lazy {
		// Apply flip to children
		tree[2*nodeIdx].ones, tree[2*nodeIdx].zeros = tree[2*nodeIdx].zeros, tree[2*nodeIdx].ones
		tree[2*nodeIdx+1].ones, tree[2*nodeIdx+1].zeros = tree[2*nodeIdx+1].zeros, tree[2*nodeIdx+1].ones

		// Flip children's lazy flags
		tree[2*nodeIdx].lazy = !tree[2*nodeIdx].lazy
		tree[2*nodeIdx+1].lazy = !tree[2*nodeIdx+1].lazy

		// Reset current node's lazy flag
		tree[nodeIdx].lazy = false
	}
}

func update(tree []Node, nodeIdx, start, end, l, r int) {
	if r < start || end < l {
		return
	}
	if l <= start && end <= r {
		tree[nodeIdx].ones, tree[nodeIdx].zeros = tree[nodeIdx].zeros, tree[nodeIdx].ones
		tree[nodeIdx].lazy = !tree[nodeIdx].lazy
		return
	}

	pushDown(tree, nodeIdx)

	mid := (start + end) / 2
	update(tree, nodeIdx*2, start, mid, l, r)
	update(tree, nodeIdx*2+1, mid+1, end, l, r)

	tree[nodeIdx].ones = tree[nodeIdx*2].ones + tree[nodeIdx*2+1].ones
	tree[nodeIdx].zeros = tree[nodeIdx*2].zeros + tree[nodeIdx*2+1].zeros
}

func handleQuery(nums1 []int, nums2 []int, queries [][]int) []int64 {
	n1 := len(nums1)
	n2 := len(nums2)

	tree := make([]Node, 4*n1)
	build(nums1, tree, 1, 0, n1-1)

	prefixSum2 := make([]int64, n2+1)
	var totalSumNums2 int64
	for i := 0; i < n2; i++ {
		prefixSum2[i+1] = prefixSum2[i] + int64(nums2[i])
		totalSumNums2 += int64(nums2[i])
	}

	results := []int64{}

	for _, query := range queries {
		qType := query[0]
		if qType == 0 {
			l, r := query[1], query[2]
			update(tree, 1, 0, n1-1, l, r)
		} else if qType == 1 {
			l, r := query[1], query[2]
			sum := prefixSum2[r+1] - prefixSum2[l]
			results = append(results, sum)
		} else { // qType == 2
			currentOnesInNums1 := int64(tree[1].ones)
			results = append(results, currentOnesInNums1*totalSumNums2)
		}
	}

	return results
}