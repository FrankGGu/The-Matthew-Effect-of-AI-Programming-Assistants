package main

import (
	"math"
	"sort"
)

func minWastedSpace(packages []int, suppliers [][]int) int {
	const MOD = 1e9 + 7

	sort.Ints(packages)
	n := len(packages)

	prefixSum := make([]int64, n+1)
	for i := 0; i < n; i++ {
		prefixSum[i+1] = prefixSum[i] + int64(packages[i])
	}

	minWastedSpace := int64(math.MaxInt64)

	for _, supplierBoxes := range suppliers {
		sort.Ints(supplierBoxes)

		currentSupplierWastedSpace := int64(0)
		packageIdx := 0 // Pointer to the first package not yet covered

		for _, boxSize := range supplierBoxes {
			if packageIdx == n { // All packages are already covered
				break
			}
			if boxSize < packages[packageIdx] { // This box is too small for the current package
				continue
			}

			// Find the index of the first package strictly greater than boxSize
			// packages[packageIdx:] is the slice of packages yet to be covered
			// sort.SearchInts returns index relative to this slice
			// Add packageIdx to get the absolute index in the original 'packages' slice
			nextPackageIdx := sort.SearchInts(packages[packageIdx:], boxSize+1) + packageIdx

			// Packages from packageIdx to nextPackageIdx-1 can be covered by boxSize
			// Number of packages covered: nextPackageIdx - packageIdx
			count := int64(nextPackageIdx - packageIdx)

			// Sum of packages covered: prefixSum[nextPackageIdx] - prefixSum[packageIdx]
			sumPackagesCovered := prefixSum[nextPackageIdx] - prefixSum[packageIdx]

			currentSupplierWastedSpace += (count * int64(boxSize)) - sumPackagesCovered
			packageIdx = nextPackageIdx
		}

		// Check if all packages were covered by this supplier
		if packageIdx == n {
			if currentSupplierWastedSpace < minWastedSpace {
				minWastedSpace = currentSupplierWastedSpace
			}
		}
	}

	if minWastedSpace == math.MaxInt64 {
		return -1
	}

	return int(minWastedSpace % MOD)
}