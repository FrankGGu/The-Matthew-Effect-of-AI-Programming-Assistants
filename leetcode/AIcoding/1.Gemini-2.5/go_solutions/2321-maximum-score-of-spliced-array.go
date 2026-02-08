func maximumsSplicedArray(nums1 []int, nums2 []int) int {
    n := len(nums1)

    sum1 := 0
    for _, x := range nums1 {
        sum1 += x
    }

    sum2 := 0
    for _, x := range nums2 {
        sum2