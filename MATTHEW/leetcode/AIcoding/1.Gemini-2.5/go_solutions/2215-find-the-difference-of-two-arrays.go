package main

func findDifference(nums1 []int, nums2 []int) [][]int {
	set1 := make(map[int]bool)
	set2 := make(map[int]bool)

	for _, num := range nums1 {
		set1[num] = true
	}
	for _, num := range nums2 {
		set2[num] = true
	}

	var ans1 []int
	var ans2 []int

	for num := range set1 {
		if _, found := set2[num]; !found {
			ans1 = append(ans1, num)
		}
	}

	for num := range set2 {
		if _, found := set1[num]; !found {
			ans2 = append(ans2, num)
		}
	}

	return [][]int{ans1, ans2}
}