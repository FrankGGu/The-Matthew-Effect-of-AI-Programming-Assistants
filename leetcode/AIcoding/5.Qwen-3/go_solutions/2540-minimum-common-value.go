package main

func biSearch(nums []int, target int) bool {
    left, right := 0, len(nums)-1
    for left <= right {
        mid := left + (right-left)/2
        if nums[mid] == target {
            return true
        } else if nums[mid] < target {
            left = mid + 1
        } else {
            right = mid - 1
        }
    }
    return false
}

func getCommon(nums1 []int, nums2 []int) int {
    if len(nums1) > len(nums2) {
        nums1, nums2 = nums2, nums1
    }
    for _, num := range nums1 {
        if biSearch(nums2, num) {
            return num
        }
    }
    return -1
}