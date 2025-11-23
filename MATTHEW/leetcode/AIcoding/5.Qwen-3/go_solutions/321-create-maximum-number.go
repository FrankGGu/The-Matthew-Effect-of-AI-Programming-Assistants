package main

func maxNumber(nums1 []int, nums2 []int, k int) []int {
    var merge = func(a, b []int) []int {
        result := make([]int, 0, len(a)+len(b))
        i, j := 0, 0
        for i < len(a) || j < len(b) {
            if i < len(a) && (j >= len(b) || a[i] > b[j]) {
                result = append(result, a[i])
                i++
            } else {
                result = append(result, b[j])
                j++
            }
        }
        return result
    }

    var getDigits = func(nums []int, k int) []int {
        result := make([]int, 0, k)
        drop := len(nums) - k
        for i := 0; i < len(nums); i++ {
            for drop > 0 && len(result) > 0 && result[len(result)-1] < nums[i] {
                result = result[:len(result)-1]
                drop--
            }
            result = append(result, nums[i])
        }
        return result[:k]
    }

    maxNum := make([]int, 0)
    for i := max(0, k-len(nums2)); i <= min(k, len(nums1)); i++ {
        candidate1 := getDigits(nums1, i)
        candidate2 := getDigits(nums2, k-i)
        current := merge(candidate1, candidate2)
        if len(current) > len(maxNum) || (len(current) == len(maxNum) && isGreater(current, maxNum)) {
            maxNum = current
        }
    }
    return maxNum
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

func isGreater(a, b []int) bool {
    for i := 0; i < len(a); i++ {
        if a[i] > b[i] {
            return true
        } else if a[i] < b[i] {
            return false
        }
    }
    return false
}