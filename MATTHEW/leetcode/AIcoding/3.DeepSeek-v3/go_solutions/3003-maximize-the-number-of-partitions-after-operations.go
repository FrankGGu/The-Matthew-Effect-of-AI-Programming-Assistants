func maxPartitionsAfterOperations(s string, k int) int {
    n := len(s)
    memo := make(map[[3]int]int)

    var dfs func(int, int, bool) int
    dfs = func(i, mask int, changed bool) int {
        if i == n {
            return 1
        }
        key := [3]int{i, mask, boolToInt(changed)}
        if val, ok := memo[key]; ok {
            return val
        }

        res := 0
        newMask := mask | (1 << (s[i] - 'a'))
        bitCount := bits.OnesCount(uint(newMask))

        if bitCount > k {
            res = 1 + dfs(i+1, 1 << (s[i] - 'a'), changed)
        } else {
            res = dfs(i+1, newMask, changed)
        }

        if !changed {
            for c := 0; c < 26; c++ {
                tmpMask := mask | (1 << c)
                tmpBitCount := bits.OnesCount(uint(tmpMask))
                if tmpBitCount > k {
                    tmpRes := 1 + dfs(i+1, 1 << c, true)
                    if tmpRes > res {
                        res = tmpRes
                    }
                } else {
                    tmpRes := dfs(i+1, tmpMask, true)
                    if tmpRes > res {
                        res = tmpRes
                    }
                }
            }
        }

        memo[key] = res
        return res
    }

    return dfs(0, 0, false)
}

func boolToInt(b bool) int {
    if b {
        return 1
    }
    return 0
}