package main

type Node struct {
	count int
	sum   int
}

type Peaks struct {
	nums []int
	tree []Node
	n    int
}

func Constructor(nums []int) Peaks {
	n := len(nums)
	p := Peaks{
		nums: make([]int, n),
		tree: make([]Node, 4*n), // 4*n is a common size for segment tree array
		n:    n,
	}
	copy(p.nums, nums)

	// Initialize the segment tree by adding all initial peaks.
	// Peaks can only exist at indices from 1 to n-2.
	for i := 1; i < n-1; i++ {
		if p.isPeak(i) {
			p.update(1, 0, n-1, i, p.nums[i], 1) // opType 1 for add
		}
	}
	return p
}

func (p *Peaks) isPeak(idx int) bool {
	if idx <= 0 || idx >= p.n-1 {
		return false
	}
	return p.nums[idx] > p.nums[idx-1] && p.nums[idx] > p.nums[idx+1]
}

func (p *Peaks) update(nodeIdx, segL, segR, targetIdx, val, opType int) {
	if segL == segR { // Leaf node
		p.tree[nodeIdx].count += opType
		p.tree[nodeIdx].sum += opType * val
		return
	}

	mid := segL + (segR-segL)/2
	if targetIdx <= mid {
		p.update(2*nodeIdx, segL, mid, targetIdx, val, opType)
	} else {
		p.update(2*nodeIdx+1, mid+1, segR, targetIdx, val, opType)
	}
	// Merge children results
	p.tree[nodeIdx].count = p.tree[2*nodeIdx].count + p.tree[2*nodeIdx+1].count
	p.tree[nodeIdx].sum = p.tree[2*nodeIdx].sum + p.tree[2*nodeIdx+1].sum
}

func (p *Peaks) query(nodeIdx, segL, segR, queryL, queryR int) Node {
	// No overlap
	if queryL > segR || queryR < segL {
		return Node{0, 0}
	}
	// Full overlap
	if queryL <= segL && segR <= queryR {
		return p.tree[nodeIdx]
	}

	mid := segL + (segR-segL)/2
	leftResult := p.query(2*nodeIdx, segL, mid, queryL, queryR)
	rightResult := p.query(2*nodeIdx+1, mid+1, segR, queryL, queryR)

	return Node{
		count: leftResult.count + rightResult.count,
		sum:   leftResult.sum + rightResult.sum,
	}
}

func (p *Peaks) Change(index int, val int) {
	// Affected indices are index-1, index, and index+1.
	// Store old peak statuses for these indices before updating nums[index].
	affectedIndices := make([]int, 0, 3)
	if index > 0 {
		affectedIndices = append(affectedIndices, index-1)
	}
	affectedIndices = append(affectedIndices, index)
	if index < p.n-1 {
		affectedIndices = append(affectedIndices, index+1)
	}

	oldPeakStatuses := make(map[int]bool)
	for _, idx := range affectedIndices {
		// Only check peak status for indices that can potentially be peaks (0 < idx < n-1).
		if idx > 0 && idx < p.n-1 {
			oldPeakStatuses[idx] = p.isPeak(idx)
		}
	}

	// Update the value in the array.
	p.nums[index] = val

	// Re-evaluate peak statuses and update the segment tree.
	for _, idx := range affectedIndices {
		if idx > 0 && idx < p.n-1 { // Only consider indices that can be peaks.
			newPeakStatus := p.isPeak(idx)
			if newPeakStatus != oldPeakStatuses[idx] {
				if newPeakStatus { // Was not a peak, now is -> add to tree
					p.update(1, 0, p.n-1, idx, p.nums[idx], 1)
				} else { // Was a peak, now is not -> remove from tree
					p.update(1, 0, p.n-1, idx, p.nums[idx], -1)
				}
			}
		}
	}
}

func (p *Peaks) CountPeaks(left int, right int) int {
	// Peaks can only exist at indices from 1 to n-2.
	// Adjust the query range to be within these valid peak indices.
	queryL := max(1, left)
	queryR := min(p.n-2, right)

	if queryL > queryR { // No valid peak indices in the query range.
		return 0
	}
	result := p.query(1, 0, p.n-1, queryL, queryR)
	return result.count
}

func (p *Peaks) SumPeaks(left int, right int) int {
	// Peaks can only exist at indices from 1 to n-2.
	// Adjust the query range to be within these valid peak indices.
	queryL := max(1, left)
	queryR := min(p.n-2, right)

	if queryL > queryR { // No valid peak indices in the query range.
		return 0
	}
	result := p.query(1, 0, p.n-1, queryL, queryR)
	return result.sum
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}