func kthSmallestProduct(nums1 []int, nums2 []int, k int64) int64 {
	m, n := len(nums1), len(nums2)
	left, right := int64(-1e10), int64(1e10)

	count := func(mid int64) int64 {
		cnt := int64(0)
		for i := 0; i < m; i++ {
			if nums1[i] >= 0 {
				l, r := 0, n
				for l < r {
					mid2 := (l + r) / 2
					if int64(nums1[i])*int64(nums2[mid2]) <= mid {
						l = mid2 + 1
					} else {
						r = mid2
					}
				}
				cnt += int64(l)
			} else {
				l, r := 0, n
				for l < r {
					mid2 := (l + r) / 2
					if int64(nums1[i])*int64(nums2[mid2]) <= mid {
						r = mid2
					} else {
						l = mid2 + 1
					}
				}
				cnt += int64(n - l)
			}
		}
		return cnt
	}

	for left < right {
		mid := (left + right) / 2
		if count(mid) < k {
			left = mid + 1
		} else {
			right = mid
		}
	}
	return left
}