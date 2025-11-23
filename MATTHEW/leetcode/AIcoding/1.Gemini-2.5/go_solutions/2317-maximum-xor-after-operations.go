func maximumXOR(nums []int) int {
    // The key observation is that the operation `nums[i] = nums[i] & (nums[i] ^ x)`
    // can only turn a 1-bit into a 0-bit. It can never turn a 0-bit into a 1-bit.