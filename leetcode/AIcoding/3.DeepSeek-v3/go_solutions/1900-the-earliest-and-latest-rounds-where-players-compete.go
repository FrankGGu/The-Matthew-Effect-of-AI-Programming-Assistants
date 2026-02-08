func earliestAndLatest(n int, firstPlayer int, secondPlayer int) []int {
    memo := make(map[string][2]int)
    var dfs func(int, int, int, int) (int, int)
    dfs = func(mask, round, left, right int) (int, int) {
        key := fmt.Sprintf("%d-%d-%d", mask, left, right)
        if val, ok := memo[key]; ok {
            return val[0], val[1]
        }
        if left >= right {
            newMask := 0
            cnt := 0
            for i := 0; i < n; i++ {
                if mask&(1<<i) != 0 {
                    if cnt < left {
                        newMask |= 1 << cnt
                    }
                    cnt++
                }
            }
            return dfs(newMask, round+1, 0, bits.OnesCount(uint(newMask))-1)
        } else if (mask&(1<<left)) != 0 && (mask&(1<<right)) != 0 {
            if left+1 == right {
                return round, round
            }
            newMask := mask &^ (1 << left) &^ (1 << right)
            minR, maxR := dfs(newMask, round+1, 0, bits.OnesCount(uint(newMask))-1)
            return minR, maxR
        } else {
            minE, maxE := math.MaxInt32, math.MinInt32
            if (mask & (1 << left)) == 0 {
                e1, l1 := dfs(mask, round, left+1, right)
                if e1 < minE {
                    minE = e1
                }
                if l1 > maxE {
                    maxE = l1
                }
            }
            if (mask & (1 << right)) == 0 {
                e2, l2 := dfs(mask, round, left, right-1)
                if e2 < minE {
                    minE = e2
                }
                if l2 > maxE {
                    maxE = l2
                }
            }
            memo[key] = [2]int{minE, maxE}
            return minE, maxE
        }
    }
    initialMask := (1 << n) - 1
    earliest, latest := dfs(initialMask, 1, 0, n-1)
    return []int{earliest, latest}
}