func minOperations(nums1 []int, nums2 []int) int {
    n := len(nums1)
    if n == 1 {
        return 0
    }

    count1, count2 := 0, 0
    last1, last2 := nums1[n-1], nums2[n-1]

    for i := 0; i < n-1; i++ {
        if nums1[i] <= last1 && nums2[i] <= last2 {
            continue
        } else if nums2[i] <= last1 && nums1[i] <= last2 {
            count1++
        } else {
            count1 = -1
            break
        }
    }

    for i := 0; i < n-1; i++ {
        if nums1[i] <= last2 && nums2[i] <= last1 {
            continue
        } else if nums2[i] <= last2 && nums1[i] <= last1 {
            count2++
        } else {
            count2 = -1
            break
        }
    }

    if count1 == -1 && count2 == -1 {
        return -1
    } else if count1 == -1 {
        return count2
    } else if count2 == -1 {
        return count1
    } else {
        return min(count1, count2)
    }
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}