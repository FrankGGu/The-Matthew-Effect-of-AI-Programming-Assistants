func judgePoint24(cards []int) bool {
    nums := make([]float64, len(cards))
    for i, num := range cards {
        nums[i] = float64(num)
    }
    return dfs(nums)
}

func dfs(nums []float64) bool {
    if len(nums) == 1 {
        return math.Abs(nums[0]-24) < 1e-6
    }
    for i := 0; i < len(nums); i++ {
        for j := 0; j < len(nums); j++ {
            if i == j {
                continue
            }
            var next []float64
            for k := 0; k < len(nums); k++ {
                if k != i && k != j {
                    next = append(next, nums[k])
                }
            }
            for _, op := range []byte{'+', '-', '*', '/'} {
                if (op == '+' || op == '*') && i > j {
                    continue
                }
                var res float64
                switch op {
                case '+':
                    res = nums[i] + nums[j]
                case '-':
                    res = nums[i] - nums[j]
                case '*':
                    res = nums[i] * nums[j]
                case '/':
                    if nums[j] == 0 {
                        continue
                    }
                    res = nums[i] / nums[j]
                }
                next = append(next, res)
                if dfs(next) {
                    return true
                }
                next = next[:len(next)-1]
            }
        }
    }
    return false
}