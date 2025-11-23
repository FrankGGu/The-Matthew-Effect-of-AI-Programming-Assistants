func minCost(s string, cost []int) int {
    res := 0
    n := len(s)
    for i := 0; i < n; {
        j := i
        maxCost := cost[i]
        sum := cost[i]
        for j+1 < n && s[j] == s[j+1] {
            j++
            if cost[j] > maxCost {
                maxCost = cost[j]
            }
            sum += cost[j]
        }
        if j > i {
            res += sum - maxCost
        }
        i = j + 1
    }
    return res
}