func smallestSubarrays(nums []int) []int {
    n := len(nums)
    ans := make([]int, n)

    // last_occurrence[k] stores the rightmost index `j` such that the k-th bit is set in nums[j].
    // Initialize with -1 to indicate no bit has been set