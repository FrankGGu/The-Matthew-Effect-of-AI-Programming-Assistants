func maxNumber(nums1 []int, nums2 []int, k int) []int {
    n1 := len(nums1)
    n2 := len(nums2)
    maxResult := make([]int, k) // Initialize with zeros, which is the smallest possible k-digit number

    // Iterate through all possible splits of k digits