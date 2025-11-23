func maxProfit(inventory []int, orders int) int {
    const mod = 1_000_000_007
    n := len(inventory)
    inventoryMap := make(map[int]int)

    for _, val := range inventory {
        inventoryMap[val]++
    }

    uniqueHeights := make([]int, 0, len(inventoryMap))
    for height := range inventoryMap {
        uniqueHeights = append(uniqueHeights, height)
    }

    sort.Sort(sort.Reverse(sort.IntSlice(uniqueHeights)))

    totalProfit := 0
    for i := 0; i < len(uniqueHeights) && orders > 0; i++ {
        currentHeight := uniqueHeights[i]
        nextHeight := 0
        if i+1 < len(uniqueHeights) {
            nextHeight = uniqueHeights[i+1]
        }

        count := inventoryMap[currentHeight]
        maxOrders := count * (currentHeight - nextHeight)

        if orders >= maxOrders {
            totalProfit = (totalProfit + count*(currentHeight*(currentHeight+1)/2-nextHeight*(nextHeight+1)/2)) % mod) % mod
            orders -= maxOrders
        } else {
            fullHeight := orders / count
            remainingOrders := orders % count
            totalProfit = (totalProfit + count*(currentHeight*(currentHeight+1)/2-(currentHeight-fullHeight)*(currentHeight-fullHeight+1)/2)) % mod
            totalProfit = (totalProfit + remainingOrders*(currentHeight-fullHeight)) % mod
            orders = 0
        }
    }

    return totalProfit
}