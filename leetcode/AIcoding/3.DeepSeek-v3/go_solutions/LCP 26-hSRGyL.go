func minTransfers(transactions [][]int) int {
    balance := make(map[int]int)
    for _, t := range transactions {
        balance[t[0]] -= t[2]
        balance[t[1]] += t[2]
    }
    debts := make([]int, 0)
    for _, v := range balance {
        if v != 0 {
            debts = append(debts, v)
        }
    }
    return dfs(debts, 0)
}

func dfs(debts []int, start int) int {
    for start < len(debts) && debts[start] == 0 {
        start++
    }
    if start == len(debts) {
        return 0
    }
    minTrans := math.MaxInt32
    for i := start + 1; i < len(debts); i++ {
        if debts[i]*debts[start] < 0 {
            debts[i] += debts[start]
            trans := 1 + dfs(debts, start+1)
            if trans < minTrans {
                minTrans = trans
            }
            debts[i] -= debts[start]
        }
    }
    return minTrans
}