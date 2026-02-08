func shoppingOffers(price []int, special [][]int, needs []int) int {
    memo := make(map[string]int)
    return dfs(price, special, needs, memo)
}

func dfs(price []int, special [][]int, needs []int, memo map[string]int) int {
    key := fmt.Sprintf("%v", needs)
    if val, ok := memo[key]; ok {
        return val
    }

    total := 0
    for i, p := range price {
        total += needs[i] * p
    }

    for _, s := range special {
        newNeeds := make([]int, len(needs))
        for i := 0; i < len(needs); i++ {
            if needs[i] < s[i] {
                break
            }
            newNeeds[i] = needs[i] - s[i]
        }
        if len(newNeeds) == len(needs) {
            total = min(total, s[len(s)-1]+dfs(price, special, newNeeds, memo))
        }
    }

    memo[key] = total
    return total
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}