func closestToTarget(arr []int, target int) int {
    res := math.MaxInt32
    current := make(map[int]bool)
    for _, num := range arr {
        next := make(map[int]bool)
        next[num] = true
        for val := range current {
            next[val|num] = true
        }
        for val := range next {
            if abs(val - target) < abs(res - target) {
                res = val
            }
        }
        current = next
    }
    return abs(res - target)
}

func abs(x int) int {
    if x < 0 {
        return -x
    }
    return x
}