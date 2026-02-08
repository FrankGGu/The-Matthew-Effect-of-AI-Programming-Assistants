func minEqualSum(nums1 []int, nums2 []int) int64 {
	var s1, z1 int64
	for _, num := range nums1 {
		if num == 0 {
			z1++
		} else {
			s1 += int64(num)
		}
	}

	var s2, z2 int64
	for _, num := range nums2 {
		if num == 0 {
			z2++
		} else {
			s2 += int64(num)
		}
	}

	minSum1 := s1 + z1
	minSum2 := s2 + z2

	if z1 == 0 && z2 == 0 {
		if s1 == s2 {
			return s1
		}
		return -1
	}

	if z1 == 0 { // z2 must be > 0 here
		if s1 < minSum2 {
			return -1
		}
		return s1
	}

	if z2 == 0 { // z1 must be > 0 here
		if s2 < minSum1 {
			return -1
		}
		return s2
	}

	// Both z1 > 0 and z2 > 0
	if minSum1 > minSum2 {
		return minSum1
	}
	return minSum2
}