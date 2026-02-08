import "math"

func judgePoint24(cards []int) bool {
    var dfs func([]float64) bool
    dfs = func(nums []float64) bool {
        if len(nums) == 1 {
            return math.Abs(nums[0]-24) < 1e-6
        }
        for i := 0; i < len(nums); i++ {
            for j := 0; j < len(nums); j++ {
                if i != j {
                    next := []float64{}
                    for k := 0; k < len(nums); k++ {
                        if k != i && k != j {
                            next = append(next, nums[k])
                        }
                    }
                    a, b := nums[i], nums[j]
                    next = append(next, a+b, a-b, b-a, a*b)
                    if b != 0 {
                        next = append(next, a/b)
                    }
                    if a != 0 {
                        next = append(next, b/a)
                    }
                    for _, v := range next {
                        if dfs(append([]float64{}, next[:len(next)-1]...)) {
                            return true
                        }
                    }
                }
            }
        }
        return false
    }
    numCards := []float64{float64(cards[0]), float64(cards[1]), float64(cards[2]), float64(cards[3])}
    return dfs(numCards)
}