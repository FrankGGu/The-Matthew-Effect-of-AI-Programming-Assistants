import "sort"

func minOperations(nums1 []int, nums2 []int) int {
    sum1, sum2 := 0, 0
    for _, v := range nums1 {
        sum1 += v
    }
    for _, v := range nums2 {
        sum2 += v
    }
    if sum1 > sum2 {
        nums1, nums2 = nums2, nums1
        sum1, sum2 = sum2, sum1
    }
    if len(nums1)*6 < len(nums2) {
        return -1
    }
    if len(nums2)*6 < len(nums1) {
        return -1
    }
    if sum1 == sum2 {
        return 0
    }

    diff := sum2 - sum1
    sort.Ints(nums1)
    sort.Sort(sort.Reverse(sort.IntSlice(nums2)))

    i, j := 0, 0
    count := 0
    for diff > 0 && (i < len(nums1) || j < len(nums2)) {
        val1, val2 := 0, 0
        if i < len(nums1) {
            val1 = 6 - nums1[i]
        }
        if j < len(nums2) {
            val2 = nums2[j] - 1
        }

        if val1 >= val2 {
            if i < len(nums1) {
                diff -= 6 - nums1[i]
                i++
            } else {
                diff -= nums2[j] - 1
                j++
            }
        } else {
            if j < len(nums2) {
                diff -= nums2[j] - 1
                j++
            } else {
                diff -= 6 - nums1[i]
                i++
            }
        }
        count++
    }

    if diff > 0 {
        return -1
    }

    return count
}