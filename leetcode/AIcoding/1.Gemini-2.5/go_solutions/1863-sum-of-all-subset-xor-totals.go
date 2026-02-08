func subsetXORSum(nums []int) int {
    // Calculate the bitwise OR of all elements in nums.
    // This value, let's call it `overallOR`, will have a bit set
    // if that bit is set in at least one number in the `nums` array.
    overallOR := 0
    for _, num := range nums {
        overallOR |= num
    }

    // The sum of all subset XOR totals for an array of length N
    // is equal to (2^(N-1)) * overallOR.
    // This property holds because for each bit position that is set in `overallOR`,
    // it will contribute to the total sum `2^(N-1)` times.
    // If N is 0 (empty nums), the sum is 0. However, problem constraints state 1 <= nums.length.
    // `1 << (len(nums) - 1)` calculates 2^(N-1).
    return overallOR * (1 << (len(nums) - 1))
}