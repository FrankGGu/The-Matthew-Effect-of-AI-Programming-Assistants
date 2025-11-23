func flipgame(fronts []int, backs []int) int {
    same := make(map[int]bool)
    for i := 0; i < len(fronts); i++ {
        if fronts[i] == backs[i] {
            same[fronts[i]] = true
        }
    }
    res := math.MaxInt32
    for _, num := range fronts {
        if !same[num] && num < res {
            res = num
        }
    }
    for _, num := range backs {
        if !same[num] && num < res {
            res = num
        }
    }
    if res == math.MaxInt32 {
        return 0
    }
    return res
}