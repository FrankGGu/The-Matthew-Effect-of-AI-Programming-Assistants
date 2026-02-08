func countInterestingSubarrays(nums []int, modulo int, k int) int {
    count := 0
    prefixCount := make(map[int]int)
    prefixCount[0] = 1
    currentSum := 0

    for _, num := range nums {
        if num % modulo == k {
            currentSum++
        }
        currentSum %= modulo
        target := (currentSum - k + modulo) % modulo
        count += prefixCount[target]
        prefixCount[currentSum]++
    }

    return count
}