func maximumCandies(candies []int, k int) int {
    var maxPile int
    for _, pile := range candies {
        if pile > maxPile {
            maxPile = pile
        }
    }

    left := 0
    right := maxPile
    ans := 0

    for left <= right {