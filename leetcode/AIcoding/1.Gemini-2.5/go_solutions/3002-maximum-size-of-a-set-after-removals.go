package main

func maximumSetSize(nums1 []int, nums2 []int) int {
	n := len(nums1)
	halfN := n / 2

	s1Distinct := make(map[int]bool)
	for _, num := range nums1 {
		s1Distinct[num] = true
	}

	s2Distinct := make(map[int]bool)
	for _, num := range nums2 {
		s2Distinct[num] = true
	}

	uniqueIn1 := 0
	commonInBoth := 0
	for num := range s1Distinct {
		if _, found := s2Distinct[num]; found {
			commonInBoth++
		} else {
			uniqueIn1++
		}
	}

	uniqueIn2 := 0
	for num := range s2Distinct {
		if _, found := s1Distinct[num]; !found {
			uniqueIn2++
		}
	}

	p1Unique := min(uniqueIn1, halfN)
	rem1 := halfN - p1Unique

	p2Unique := min(uniqueIn2, halfN)
	rem2 := halfN - p2Unique

	commonPicked := min(commonInBoth, rem1+rem2)

	totalDistinct := p1Unique + p2Unique + commonPicked

	return min(totalDistinct, n)
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}