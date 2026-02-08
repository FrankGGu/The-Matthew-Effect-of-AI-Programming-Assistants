package main

func minimizeMax(nums1 []int, nums2 []int) int {
    sort.Ints(nums1)
    sort.Ints(nums2)
    n := len(nums1)
    m := len(nums2)
    left, right := 0, 1e9
    for left < right {
        mid := (left + right) / 2
        i, j := 0, 0
        count := 0
        for i < n && j < m {
            if nums1[i] <= nums2[j]+mid {
                count++
                i++
            } else {
                j++
            }
        }
        if count >= n {
            right = mid
        } else {
            left = mid + 1
        }
    }
    return left
}