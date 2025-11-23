func minimumMountainRemovals(nums []int) int {
    n := len(nums)

    // lis[i] stores the length of the longest increasing subsequence ending at nums[i]
    lis := make([]int, n)
    for i := range lis {
        lis[i] = 1
    }

    for i :=