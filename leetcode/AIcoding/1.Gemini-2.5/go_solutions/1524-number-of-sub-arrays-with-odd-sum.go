func numOfSubarrays(arr []int) int {
    const MOD = 1_000_000_007

    oddPrefixCount := 0
    evenPrefixCount := 1 // Represents the prefix sum of 0 before any elements, which is even.

    currentSum := 0