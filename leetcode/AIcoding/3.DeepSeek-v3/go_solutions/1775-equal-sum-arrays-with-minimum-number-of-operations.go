func minOperations(nums1 []int, nums2 []int) int {
    sum1, sum2 := 0, 0
    for _, num := range nums1 {
        sum1 += num
    }
    for _, num := range nums2 {
        sum2 += num
    }
    if sum1 == sum2 {
        return 0
    }
    if sum1 > sum2 {
        return helper(nums1, nums2, sum1-sum2)
    }
    return helper(nums2, nums1, sum2-sum1)
}

func helper(larger, smaller []int, diff int) int {
    changes := make([]int, 0)
    for _, num := range larger {
        changes = append(changes, num-1)
    }
    for _, num := range smaller {
        changes = append(changes, 6-num)
    }
    sort.Sort(sort.Reverse(sort.IntSlice(changes)))
    res := 0
    for _, change := range changes {
        if diff <= 0 {
            break
        }
        diff -= change
        res++
    }
    if diff > 0 {
        return -1
    }
    return res
}