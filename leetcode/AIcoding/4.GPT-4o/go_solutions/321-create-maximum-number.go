func maxNumber(nums1 []int, nums2 []int, k int) []int {
    n1, n2 := len(nums1), len(nums2)
    maxResult := make([]int, 0, k)

    for i := max(0, k-n2); i <= min(k, n1); i++ {
        part1 := getMaxArray(nums1, i)
        part2 := getMaxArray(nums2, k-i)
        merged := merge(part1, part2)
        maxResult = maxSlice(maxResult, merged)
    }

    return maxResult
}

func getMaxArray(nums []int, k int) []int {
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
    merged := make([]int, 0, len(nums1)+len(nums2))
    i, j := 0, 0
    for i < len(nums1) || j < len(nums2) {
        if less(nums1[i:], nums2[j:]) {
            merged = append(merged, nums2[j])
            j++
        } else {
            merged = append(merged, nums1[i])
            i++
        }
    }
    return merged
}

func less(nums1, nums2 []int) bool {
    for i := 0; i < min(len(nums1), len(nums2)); i++ {
        if nums1[i] != nums2[i] {
            return nums1[i] < nums2[i]
        }
    }
    return len(nums1) < len(nums2)
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func maxSlice(nums1, nums2 []int) []int {
    if less(nums1, nums2) {
        return nums2
    }
    return nums1
}