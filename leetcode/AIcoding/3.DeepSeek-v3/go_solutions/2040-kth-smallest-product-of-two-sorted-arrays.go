func kthSmallestProduct(nums1 []int, nums2 []int, k int64) int64 {
    left, right := int64(-1e10), int64(1e10)
    for left < right {
        mid := left + (right-left)/2
        count := countLessOrEqual(nums1, nums2, mid)
        if count < k {
            left = mid + 1
        } else {
            right = mid
        }
    }
    return left
}

func countLessOrEqual(nums1, nums2 []int, target int64) int64 {
    var count int64
    for _, num1 := range nums1 {
        x := int64(num1)
        if x == 0 {
            if target >= 0 {
                count += int64(len(nums2))
            }
            continue
        }
        if x > 0 {
            l, r := 0, len(nums2)
            for l < r {
                mid := l + (r-l)/2
                if x*int64(nums2[mid]) <= target {
                    l = mid + 1
                } else {
                    r = mid
                }
            }
            count += int64(l)
        } else {
            l, r := 0, len(nums2)
            for l < r {
                mid := l + (r-l)/2
                if x*int64(nums2[mid]) <= target {
                    r = mid
                } else {
                    l = mid + 1
                }
            }
            count += int64(len(nums2) - l)
        }
    }
    return count
}