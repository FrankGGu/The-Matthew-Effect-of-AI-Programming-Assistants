func numSubarrayBoundedMax(nums []int, left int, right int) int {
    return countSubarraysLessThanOrEqualToK(nums, right) - countSubarraysLessThanOrEqualToK(nums, left-1)
}

func countSubarraysLessThanOrEqualToK(nums []int, k int) int {
    count := 0