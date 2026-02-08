package main

func findMedianSortedArrays(nums1 []int, nums2 []int) float64 {
	if len(nums1) > len(nums2) {
		return findMedianSortedArrays(nums2, nums1)
	}

	m, n := len(nums1), len(nums2)
	i, j, imin, imax, halfLen := 0, 0, 0, m, (m+n+1)/2

	for imin <= imax {
		i = (imin + imax) / 2
		j = halfLen - i

		if i < m && j > 0 && nums2[j-1] > nums1[i] {
			imin = i + 1
		} else if i > 0 && j < n && nums1[i-1] > nums2[j] {
			imax = i - 1
		} else {
			var maxLeft, minRight int
			if i == 0 {
				maxLeft = nums2[j-1]
			} else if j == 0 {
				maxLeft = nums1[i-1]
			} else {
				maxLeft = max(nums1[i-1], nums2[j-1])
			}

			if (m+n)%2 == 1 {
				return float64(maxLeft)
			}

			if i == m {
				minRight = nums2[j]
			} else if j == n {
				minRight = nums1[i]
			} else {
				minRight = min(nums1[i], nums2[j])
			}

			return float64(maxLeft+minRight) / 2.0
		}
	}

	return 0.0
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