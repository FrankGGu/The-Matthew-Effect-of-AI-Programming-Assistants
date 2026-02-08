func minSumSquareDiff(nums1 []int, nums2 []int, k int) int {
    n := len(nums1)
    diffs := make([]int, n)
    for i := 0; i < n; i++ {
        diffs[i] = abs(nums1[i] - nums2[i])
    }

    sort.Ints(diffs)

    low, high := 0, diffs[n-1]
    for low < high {
        mid := (low + high) / 2
        if canDistribute(diffs, mid, k) {
            high = mid
        } else {
            low = mid + 1
        }
    }

    return calculateSquareSum(diffs, low)
}

func canDistribute(diffs []int, target, k int) bool {
    total := 0
    for _, diff := range diffs {
        if diff > target {
            total += diff - target
        }
        if total > k {
            return false
        }
    }
    return true
}

func calculateSquareSum(diffs []int, target int) int {
    sum := 0
    for _, diff := range diffs {
        if diff > target {
            sum += (diff - target) * (diff - target)
        } else {
            sum += diff * diff
        }
    }
    return sum
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}