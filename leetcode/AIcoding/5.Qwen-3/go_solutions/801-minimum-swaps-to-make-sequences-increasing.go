package main

func minSwap(nums1 []int, nums2 []int) int {
    n := len(nums1)
    swap := make([]int, n)
    noSwap := make([]int, n)
    swap[0] = 1
    noSwap[0] = 0

    for i := 1; i < n; i++ {
        if nums1[i] > nums1[i-1] && nums2[i] > nums2[i-1] {
            swap[i] = swap[i-1] + 1
            noSwap[i] = noSwap[i-1]
        } else {
            swap[i] = swap[i-1] + 1
            noSwap[i] = noSwap[i-1]
        }

        if nums1[i] > nums2[i-1] && nums2[i] > nums1[i-1] {
            swap[i] = min(swap[i], noSwap[i-1]+1)
            noSwap[i] = min(noSwap[i], swap[i-1])
        }
    }

    return min(swap[n-1], noSwap[n-1])
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}