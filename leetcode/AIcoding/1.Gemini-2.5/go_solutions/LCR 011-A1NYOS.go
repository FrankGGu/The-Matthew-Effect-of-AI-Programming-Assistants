func findMaxLength(nums []int) int {
    sumMap := make(map[int]int)
    sumMap[0] = -1 // Initialize with sum 0 at index -1 to handle subarrays starting from index 0

    currentSum := 0
    maxLength := 0

    for i, num := range nums {
        if