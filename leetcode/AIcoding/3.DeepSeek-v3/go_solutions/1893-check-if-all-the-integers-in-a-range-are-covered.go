func isCovered(ranges [][]int, left int, right int) bool {
    covered := make([]bool, 51)
    for _, r := range ranges {
        for i := r[0]; i <= r[1]; i++ {
            if i <= 50 {
                covered[i] = true
            }
        }
    }
    for i := left; i <= right; i++ {
        if !covered[i] {
            return false
        }
    }
    return true
}