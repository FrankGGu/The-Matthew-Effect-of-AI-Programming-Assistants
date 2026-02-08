package main

func canSwap(nums []int, i int, k int) bool {
    for j := i; j < len(nums); j++ {
        if nums[j] == k {
            return true
        }
    }
    return false
}

func swapElements(nums []int, i int, k int) {
    for j := i; j < len(nums); j++ {
        if nums[j] == k {
            nums[i], nums[j] = nums[j], nums[i]
            break
        }
    }
}

func minArrayAfterSwaps(nums []int, k int) []int {
    for i := 0; i < len(nums); i++ {
        if nums[i] == k {
            break
        }
        if canSwap(nums, i+1, k) {
            swapElements(nums, i, k)
        } else {
            return nums
        }
    }
    return nums
}

func lexSmallestArray(nums []int, k int) []int {
    for i := 0; i < len(nums); i++ {
        if nums[i] == k {
            break
        }
        if canSwap(nums, i+1, k) {
            swapElements(nums, i, k)
        } else {
            return nums
        }
    }
    return nums
}

func makeLexicographicallySmallestArray(nums []int, k int) []int {
    return lexSmallestArray(nums, k)
}