func splitIntoFibonacci(S string) []int {
    var result []int
    n := len(S)

    var backtrack func(start int) bool
    backtrack = func(start int) bool {
        if start == n && len(result) >= 3 {
            return true
        }

        for end := start + 1; end <= n; end++ {
            numStr := S[start:end]
            if len(numStr) > 1 && numStr[0] == '0' {
                break
            }
            num, _ := strconv.Atoi(numStr)
            l := len(result)
            if l >= 2 && num > result[l-1]+result[l-2] {
                break
            }
            if l < 2 || num == result[l-1]+result[l-2] {
                result = append(result, num)
                if backtrack(end) {
                    return true
                }
                result = result[:l]
            }
        }
        return false
    }

    backtrack(0)
    return result
}