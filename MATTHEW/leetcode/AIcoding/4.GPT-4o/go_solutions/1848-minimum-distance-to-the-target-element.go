func getMinDistance(nums []int, target int, start int) int {
    minDistance := len(nums)
    for i, num := range nums {
        if num == target {
            distance := abs(i - start)
            if distance < minDistance {
                minDistance = distance
            }
        }
    }
    return minDistance
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}