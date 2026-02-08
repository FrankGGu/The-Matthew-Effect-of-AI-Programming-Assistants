func findMaxK(nums []int) int {
    numSet := make(map[int]bool)
    maxK := -1
    for _, num := range nums {
        if numSet[-num] {
            if abs(num) > maxK {
                maxK = abs(num)
            }
        }
        numSet[num] = true
    }
    return maxK
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}