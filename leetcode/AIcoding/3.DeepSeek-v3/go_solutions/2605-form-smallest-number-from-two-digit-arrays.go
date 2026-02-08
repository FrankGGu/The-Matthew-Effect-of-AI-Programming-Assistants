func minNumber(nums1 []int, nums2 []int) int {
    min1 := 10
    min2 := 10
    common := 10

    set := make(map[int]bool)
    for _, num := range nums1 {
        if num < min1 {
            min1 = num
        }
        set[num] = true
    }
    for _, num := range nums2 {
        if num < min2 {
            min2 = num
        }
        if set[num] && num < common {
            common = num
        }
    }

    if common != 10 {
        return common
    }

    if min1 < min2 {
        return min1*10 + min2
    } else {
        return min2*10 + min1
    }
}