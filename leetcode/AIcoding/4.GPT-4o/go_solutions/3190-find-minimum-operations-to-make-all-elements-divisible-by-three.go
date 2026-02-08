func minOperations(nums []int) int {
    count := [3]int{}
    for _, num := range nums {
        count[num%3]++
    }
    return min(count[1], count[2]) + abs(count[1]-count[2])/3 + count[0]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}