func findGoodPairs(nums1 []int, nums2 []int, k int) int64 {
	freq1 := make(map[int]int)
	for _, num := range nums1 {
		freq1[num]++
	}

	freq2 := make(map[int]int)
	for _, num := range nums2 {
		freq2[num]++
	}

	var ans int64 = 0

	for num1Val, count1 := range freq1 {
		if num1Val%k != 0 {
			continue
		}

		target := num1Val / k

		for d := 1; d*d <= target; d++ {
			if target%d == 0 {
				if count2, ok := freq2[d]; ok {
					ans += int64(count1) * int64(count2)
				}

				if d*d != target {
					dPrime := target / d
					if count2Prime, ok := freq2[dPrime]; ok {
						ans += int64(count1) * int64(count2Prime)
					}
				}
			}
		}
	}

	return ans
}