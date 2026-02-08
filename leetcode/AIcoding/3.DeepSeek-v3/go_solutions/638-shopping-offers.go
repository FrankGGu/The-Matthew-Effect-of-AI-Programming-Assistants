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

    for _, offer := range special {
        newNeeds := make([]int, len(needs))
        copy(newNeeds, needs)
        valid := true
        for i := 0; i < len(needs); i++ {
            if offer[i] > newNeeds[i] {
                valid = false
                break
            }
            newNeeds[i] -= offer[i]
        }
        if valid {
            cost := offer[len(offer)-1] + dfs(price, special, newNeeds, memo)
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
    for i := 0; i < len(needs); i++ {
        total += needs[i] * price[i]
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