func bestRotation(nums []int) int {
    n := len(nums)
    // diff[k] will store the change in score when moving from rotation k-1 to k
    // We need n+1 elements because diff[k] affects score[k].
    // diff[k] represents score change for rotation k.