func arithmeticTriplets(nums []int, diff int) int {
    numSet := make(map[int]bool)
    for _, num := range nums {
        numSet[num] = true
    }

    count := 0
    for _, num := range nums {
        // Check if num + diff exists in the set
        if _, foundSecond := numSet[num+diff]; foundSecond {
            // If num + diff exists, check if num + 2*diff exists
            if _, foundThird := numSet[num+2*diff]; foundThird {
                count++
            }
        }
    }

    return count
}