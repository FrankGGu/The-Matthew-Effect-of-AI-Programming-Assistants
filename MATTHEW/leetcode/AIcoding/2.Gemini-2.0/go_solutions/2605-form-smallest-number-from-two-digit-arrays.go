import (
	"sort"
	"strconv"
)

func formSmallest(nums1 []int, nums2 []int) int {
	sort.Ints(nums1)
	sort.Ints(nums2)

	for _, n1 := range nums1 {
		for _, n2 := range nums2 {
			if n1 == n2 {
				return n1
			}
		}
	}

	n1 := nums1[0]
	n2 := nums2[0]

	if n1 < n2 {
		str := strconv.Itoa(n1) + strconv.Itoa(n2)
		val, _ := strconv.Atoi(str)
		return val
	} else {
		str := strconv.Itoa(n2) + strconv.Itoa(n1)
		val, _ := strconv.Atoi(str)
		return val
	}
}