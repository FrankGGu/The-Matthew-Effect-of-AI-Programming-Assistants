func maxHappyGroups(batchSize int, groups []int) int {
    n := len(groups)
    res := 0
    freq := make([]int, batchSize)
    for _, g := range groups {
        mod := g % batchSize
        if mod == 0 {
            res++
        } else {
            freq[mod]++
        }
    }

    memo := make(map[string]int)

    var dfs func([]int, int) int
    dfs = func(freq []int, rem int) int {
        key := fmt.Sprint(freq) + "," + strconv.Itoa(rem)
        if val, ok := memo[key]; ok {
            return val
        }

        maxVal := 0
        for i := 1; i < batchSize; i++ {
            if freq[i] == 0 {
                continue
            }
            newFreq := make([]int, len(freq))
            copy(newFreq, freq)
            newFreq[i]--
            newRem := (rem - i + batchSize) % batchSize
            current := 0
            if rem == 0 {
                current = 1
            }
            total := current + dfs(newFreq, newRem)
            if total > maxVal {
                maxVal = total
            }
        }

        memo[key] = maxVal
        return maxVal
    }

    res += dfs(freq, 0)
    return res
}