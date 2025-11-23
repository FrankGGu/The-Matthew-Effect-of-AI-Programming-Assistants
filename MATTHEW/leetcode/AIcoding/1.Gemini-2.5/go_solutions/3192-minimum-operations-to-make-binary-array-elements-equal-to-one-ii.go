func minOperations(nums []int) int {
    ans := 0
    currentFlips := 0

    for i := 0; i < len(nums); i++ {
        // The effective value of nums[i] is its original value XORed with the parity of currentFlips.
        // currentFlips represents the number