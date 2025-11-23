func subarraysWithKDistinct(nums []int, k int) int {
    return atMostKDistinct(nums, k) - atMostKDistinct(nums, k-1)
}

func atMostKDistinct(nums []int, k int