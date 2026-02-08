func shoppingOffers(price []int, special [][]int, needs []int) int {
    memo := make(map[string]int)
    return dfs(price, special, needs, memo)
}

func dfs(price []int, special [][]int, needs []int, memo map[string]int) int {
    key := getKey(needs)
    if val, ok := memo[key]; ok {
        return val
    }

    minCost := directPurchase(price, needs)

    for _, s := range special {
        newNeeds := make([]int, len(needs))
        valid := true
        for i := 0; i < len(needs); i++ {
            if s[i] > needs[i] {
                valid = false
                break
            }
            newNeeds[i] = needs[i] - s[i]
        }
        if valid {
            cost := s[len(s)-1] + dfs(price, special, newNeeds, memo)
            if cost < minCost {
                minCost = cost
            }
        }
    }

    memo[key] = minCost
    return minCost
}

func directPurchase(price []int, needs []int) int {
    total := 0
    for i := 0; i < len(price); i++ {
        total += price[i] * needs[i]
    }
    return total
}

func getKey(needs []int) string {
    key := ""
    for _, n := range needs {
        key += strconv.Itoa(n) + ","
    }
    return key
}