func countHillValley(nums []int) int {
    // Step 1: Compress the array by removing consecutive duplicates.
    // This handles the problem's definition of "left neighbor" and "right neighbor"
    // when there are series of equal elements.
    compressedNums := []int{}
    if len(nums) >