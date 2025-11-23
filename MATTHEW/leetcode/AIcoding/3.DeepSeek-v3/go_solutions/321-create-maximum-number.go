func maxNumber(nums1 []int, nums2 []int, k int) []int {
    n, m := len(nums1), len(nums2)
    res := make([]int, k)
    for i := max(0, k-m); i <= min(k, n); i++ {
        s1 := maxSubsequence(nums1, i)
        s2 := maxSubsequence(nums2, k-i)
        merged := merge(s1, s2)
        if compare(merged, 0, res, 0) > 0 {
            res = merged
        }
    }
    return res
}

func maxSubsequence(nums []int, k int) []int {
    stack := make([]int, 0, k)
    drop := len(nums) - k
    for _, num := range nums {
        for drop > 0 && len(stack) > 0 && stack[len(stack)-1] < num {
            stack = stack[:len(stack)-1]
            drop--
        }
        stack = append(stack, num)
    }
    return stack[:k]
}

func merge(nums1, nums2 []int) []int {
    res := make([]int, len(nums1)+len(nums2))
    i, j := 0, 0
    for idx := 0; idx < len(res); idx++ {
        if compare(nums1, i, nums2, j) > 0 {
            res[idx] = nums1[i]
            i++
        } else {
            res[idx] = nums2[j]
            j++
        }
    }
    return res
}

func compare(nums1 []int, i int, nums2 []int, j int) int {
    for ; i < len(nums1) && j < len(nums2); i, j = i+1, j+1 {
        if nums1[i] != nums2[j] {
            return nums1[i] - nums2[j]
        }
    }
    return (len(nums1) - i) - (len(nums2) - j)
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