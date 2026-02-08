func minimumSwitches(target []int, allowed [][]int) int {
    n := len(target)
    switches := make([]int, n)
    for i := 0; i < n; i++ {
        switches[i] = -1
    }

    for i := 0; i < len(allowed); i++ {
        for _, num := range allowed[i] {
            if num <= n {
                switches[num-1] = i
            }
        }
    }

    res := 0
    current := -1
    for i := 0; i < n; i++ {
        if target[i] == 1 {
            if switches[i] == -1 {
                return -1
            }
            if current != switches[i] {
                res++
                current = switches[i]
            }
        }
    }
    return res
}