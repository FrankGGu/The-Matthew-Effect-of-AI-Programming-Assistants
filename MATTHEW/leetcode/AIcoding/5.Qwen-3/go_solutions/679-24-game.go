package main

func judgePoint24(nums []int) bool {
    var dfs func([]float64) bool
    dfs = func(cards []float64) bool {
        if len(cards) == 1 {
            return abs(cards[0]-24) < 1e-6
        }
        for i := 0; i < len(cards); i++ {
            for j := 0; j < len(cards); j++ {
                if i != j {
                    var next []float64
                    for k := 0; k < len(cards); k++ {
                        if k != i && k != j {
                            next = append(next, cards[k])
                        }
                    }
                    for _, val := range []float64{cards[i] + cards[j], cards[i] - cards[j], cards[j] - cards[i], cards[i] * cards[j]} {
                        if dfs(append(next, val)) {
                            return true
                        }
                    }
                    if cards[j] != 0 {
                        if dfs(append(next, cards[i]/cards[j])) {
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    return dfs(nums)
}

func abs(x float64) float64 {
    if x < 0 {
        return -x
    }
    return x
}