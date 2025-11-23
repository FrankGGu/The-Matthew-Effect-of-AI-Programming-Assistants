func minCost(nums1 []int, nums2 []int) int {
    count := make(map[int]int)
    totalCost := 0
    for i := 0; i < len(nums1); i++ {
        count[nums1[i]]++
        count[nums2[i]]--
    }

    minCost := 0
    for _, v := range count {
        if v > 0 {
            minCost += v
        }
    }

    return minCost
}