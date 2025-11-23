func numberOfArithmeticSlices(nums []int) int {
    n := len(nums)
    if n < 3 {
        return 0
    }

    totalSlices := 0
    // 'count' stores the number of arithmetic slices ending at the current index 'i'
    // that extend the previous arithmetic sequence.
    // For example, if nums = [1, 2, 3, 4]:
    // i=2: [1,2,3] is AP. count becomes 1. totalSlices += 1.
    // i=3: [2,3,4] is AP. [1,2,3,4] is AP. count becomes 2. totalSlices += 2.
    // Total = 1 + 2 = 3.
    count := 0 

    for i := 2; i < n; i++ {
        if nums[i]-nums[i-1] == nums[i-1]-nums[i-2] {
            // If the current triplet forms an arithmetic progression,
            // we can extend the existing arithmetic sequence.
            // The number of new arithmetic slices ending at 'i' is
            // one more than the number of arithmetic slices ending at 'i-1'
            // (that were extendable).
            count++
            totalSlices += count
        } else {
            // If the arithmetic progression is broken, reset the count.
            count = 0
        }
    }

    return totalSlices
}