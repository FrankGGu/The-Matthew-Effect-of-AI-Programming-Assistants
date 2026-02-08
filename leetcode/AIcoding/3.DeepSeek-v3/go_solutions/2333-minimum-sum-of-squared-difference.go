func minSumSquareDiff(nums1 []int, nums2 []int, k1 int, k2 int) int64 {
    n := len(nums1)
    diffs := make([]int, n)
    for i := 0; i < n; i++ {
        diffs[i] = abs(nums1[i] - nums2[i])
    }
    maxDiff := 0
    for _, d := range diffs {
        if d > maxDiff {
            maxDiff = d
        }
    }
    left, right := 0, maxDiff
    for left < right {
        mid := left + (right-left)/2
        total := 0
        for _, d := range diffs {
            if d > mid {
                total += d - mid
            }
        }
        if total <= k1+k2 {
            right = mid
        } else {
            left = mid + 1
        }
    }
    k := k1 + k2
    for i := 0; i < n; i++ {
        if diffs[i] > left {
            k -= diffs[i] - left
            diffs[i] = left
        }
    }
    for i := 0; i < n && k > 0; i++ {
        if diffs[i] > 0 {
            diffs[i]--
            k--
        }
    }
    var res int64
    for _, d := range diffs {
        res += int64(d) * int64(d)
    }
    return res
}

func abs(a int) int {
    if a < 0 {
        return -a
    }
    return a
}