func minimumCost(candies []int) int {
    sort.Ints(candies)
    totalCost := 0
    n := len(candies)

    for i := n - 1; i >= 0; i-- {
        totalCost += candies[i]
        if (n-i)%3 == 0 {
            totalCost -= candies[i]
        }
    }

    return totalCost
}