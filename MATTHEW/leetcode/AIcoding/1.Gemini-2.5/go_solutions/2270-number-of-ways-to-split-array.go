import (
	"sort"
)

type FenwickTree struct {
	tree []int
	size int
}

func newFenwickTree(size int) *FenwickTree {
	return &FenwickTree{
		tree: make([]int, size+1),
		size: size,
	}
}

func (ft *FenwickTree) update(idx, val int) {
	for idx <= ft.size {
		ft.tree[idx] += val
		idx += idx & (-idx)
	}
}

func (ft *FenwickTree) query(idx int) int {
	sum := 0
	for idx > 0 {
		sum += ft.tree[idx]
		idx -= idx & (-idx)
	}
	return sum
}

func (ft *FenwickTree) queryRange(left, right int) int {
	if left > right {
		return 0
	}
	return ft.query(right) - ft.query(left-1)
}

func waysToSplitArray(nums []int) int {
	n := len(nums)
	prefixSum := make([]int64, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + int64(nums[i])
	}

	totalSum := prefixSum[n]

	// Collect all relevant values for coordinate compression.
	// These include all prefix sums (P[k]), and the bounds for P[j+1]
	// which are 2*P[i+1] and (P[n]+P[i+1])/2.
	allValues := make(map[int64]struct{})
	for k := 0; k <= n; k++ {
		allValues[prefixSum[k]] = struct{}{}
	}
	// Add potential lower and upper bounds for P[j+1]
	// Iterate i from 0 to n-3 to generate all possible bounds
	for i := 0; i <= n-3; i++ {
		s1 := prefixSum[i+1]
		allValues[2*s1] = struct{}{}
		allValues[(totalSum+s1)/2] = struct{}{}
	}

	uniqueValues := make([]int64, 0, len(allValues))
	for val := range allValues {
		uniqueValues = append(uniqueValues, val)
	}
	sort.Slice(uniqueValues, func(a, b int) bool {
		return uniqueValues[a] < uniqueValues[b]
	})

	// Create a mapping from value to compressed index (1-based for Fenwick tree)
	valToCompIdx := make(map[int64]int)
	for i, val := range uniqueValues {
		valToCompIdx[val] = i + 1
	}

	ft := newFenwickTree(len(uniqueValues))
	ans := 0

	// Initialize Fenwick tree with prefix sums for k in [2, n-1].
	// These are the possible values for P[j+1].
	// k = j+1. Smallest j is i+1. Smallest i is 0. So smallest j is 1. Smallest k is 2.
	// Largest j is n-2. Largest k is n-1.
	for k := 2; k <= n-1; k++ {
		ft.update(valToCompIdx[prefixSum[k]], 1)
	}

	// Iterate i from 0 to n-3
	// i is the last index of the left part: nums[0...i]
	// j is the last index of the mid part: nums[i+1...j]
	// left: nums[0...i], mid: nums[i+1...j], right: nums[j+1...n-1]
	// Constraints:
	// left non-empty: i >= 0
	// mid non-empty: i+1 <= j
	// right non-empty: j+1 <= n-1 => j <= n-2
	// So, 0 <= i <= n-3
	// And i+1 <= j <= n-2
	for i := 0; i <= n-3; i++ {
		s1 := prefixSum[i+1] // sum of nums[0...i]

		// We need to count j such that:
		// s1 <= s2  => s1 <= prefixSum[j+1] - s1  => 2*s1 <= prefixSum[j+1]
		// s2 <= s3  => prefixSum[j+1] - s1 <= totalSum - prefixSum[j+1] => 2*prefixSum[j+1] <= totalSum + s1

		// So for a fixed i, we need to find j in [i+1, n-2] such that:
		// 2*s1 <= prefixSum[j+1]
		// prefixSum[j+1] <= (totalSum + s1) / 2

		targetMinVal := 2 * s1
		targetMaxVal := (totalSum + s1) / 2

		// Find compressed indices for the bounds using binary search on uniqueValues
		// compLowerBound_0based is the 0-based index of the first value >= targetMinVal
		compLowerBound_0based := sort.Search(len(uniqueValues), func(idx int) bool {
			return uniqueValues[idx] >= targetMinVal
		})
		compLowerBound := compLowerBound_0based + 1 // Convert to 1-based index for Fenwick tree

		// compUpperBound_0based is the 0-based index of the first value > targetMaxVal
		// The valid range of values is up to uniqueValues[compUpperBound_0based-1]
		compUpperBound_0based := sort.Search(len(uniqueValues), func(idx int) bool {
			return uniqueValues[idx] > targetMaxVal
		})
		compUpperBound := compUpperBound_0based // This is the 1-based upper bound (exclusive) for the BIT query

		// Query the Fenwick tree for count in the compressed range [compLowerBound, compUpperBound-1]
		countForI := ft.queryRange(compLowerBound, compUpperBound-1)
		ans += countForI

		// Remove prefixSum[i+2] from the Fenwick tree for the next iteration.
		// This is because the search range for k (j+1) shifts from [i+2, n-1] to [i+3, n-1].
		// The element prefixSum[i+2] is no longer considered as a possible P[j+1].
		// This removal is valid as long as i+2 is within the initial range [2, n-1].
		// Since i goes up to n-3, i+2 goes up to n-1, so prefixSum[i+2] is always a valid index to remove.
		ft.update(valToCompIdx[prefixSum[i+2]], -1)
	}

	return ans
}