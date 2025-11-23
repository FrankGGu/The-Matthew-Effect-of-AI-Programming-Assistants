func numSubarraysWithSum(nums []int, goal int) int {
    count := 0
    currentSum := 0
    // freq map stores the frequency of each prefix sum encountered so far.
    // Initialize with {0: 1} to handle cases where the subarray itself sums to 'goal'
    // (i.e., prefix