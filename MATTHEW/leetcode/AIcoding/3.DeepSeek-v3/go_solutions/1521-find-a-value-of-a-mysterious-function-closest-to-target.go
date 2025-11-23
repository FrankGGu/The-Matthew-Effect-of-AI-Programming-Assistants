func closestToTarget(arr []int, target int) int {
    res := math.MaxInt32
    current := make(map[int]bool)
    for _, num := range arr {
        next := make(map[int]bool)
        next[num] = true
        for val := range current {
            next[val&num] = true
        }
        for val := range next {
            diff := abs(val - target)
            if diff < res {
                res = diff
            }
        }
        current = next
    }
    return res
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}