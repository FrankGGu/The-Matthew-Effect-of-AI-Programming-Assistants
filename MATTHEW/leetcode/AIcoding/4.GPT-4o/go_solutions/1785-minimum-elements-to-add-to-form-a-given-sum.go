func minElements(nums []int, limit int, goal int) int {
    sum := 0
    for _, num := range nums {
        sum += num
    }
    diff := abs(sum - goal)
    return (diff + limit - 1) / limit
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}