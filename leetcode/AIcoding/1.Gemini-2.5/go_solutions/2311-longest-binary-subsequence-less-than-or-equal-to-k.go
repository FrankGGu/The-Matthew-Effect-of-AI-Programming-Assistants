func longestSubsequence(s string, k int) int {
    ans := 0
    currentValue := 0
    powerOf2 := 1 // Represents 2^0, 2^1, 2^2, ... from right to left

    // Iterate from right to left (least significant bit to most significant bit)