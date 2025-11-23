func splitIntoFibonacci(num string) []int {
    n := len(num)
    var res []int
    var backtrack func(index int, path []int) bool
    backtrack = func(index int, path []int) bool {
        if index == n && len(path) >= 3 {
            res = append([]int{}, path...)
            return true
        }
        for i := index; i < n; i++ {
            if num[index] == '0' && i > index {
                break
            }
            val, _ := strconv.Atoi(num[index:i+1])
            if val > math.MaxInt32 {
                break
            }
            if len(path) >= 2 {
                sum := path[len(path)-1] + path[len(path)-2]
                if val < sum {
                    continue
                } else if val > sum {
                    break
                }
            }
            if backtrack(i+1, append(path, val)) {
                return true
            }
        }
        return false
    }
    backtrack(0, []int{})
    return res
}