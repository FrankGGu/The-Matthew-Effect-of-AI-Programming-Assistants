package main

func minOperations(nums1 []int, nums2 []int, target int) int {
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
        nums1, nums2 = nums2, nums1
        sum1, sum2 = sum2, sum1
    }

    diff := sum2 - sum1
    if diff > target {
        return -1
    }

    sort.Ints(nums1)
    sort.Ints(nums2)

    i, j := len(nums1)-1, len(nums2)-1
    res := 0

    for i >= 0 || j >= 0 {
        a, b := 0, 0
        if i >= 0 {
            a = nums1[i]
        }
        if j >= 0 {
            b = nums2[j]
        }

        if a < b {
            diff -= (b - a)
            res++
            j--
        } else {
            diff -= (a - b)
            res++
            i--
        }

        if diff <= 0 {
            return res
        }
    }

    return -1
}