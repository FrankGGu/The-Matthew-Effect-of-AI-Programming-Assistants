func findCategoryRecommendationPairs(friends [][]int, purchases [][]int) [][]int {
    friendMap := make(map[int]map[int]bool)
    for _, pair := range friends {
        a, b := pair[0], pair[1]
        if friendMap[a] == nil {
            friendMap[a] = make(map[int]bool)
        }
        friendMap[a][b] = true
        if friendMap[b] == nil {
            friendMap[b] = make(map[int]bool)
        }
        friendMap[b][a] = true
    }

    userPurchases := make(map[int]map[int]bool)
    for _, purchase := range purchases {
        user, category := purchase[0], purchase[1]
        if userPurchases[user] == nil {
            userPurchases[user] = make(map[int]bool)
        }
        userPurchases[user][category] = true
    }

    categoryPairs := make(map[[2]int]bool)
    for user := range friendMap {
        for friend := range friendMap[user] {
            if userPurchases[user] == nil || userPurchases[friend] == nil {
                continue
            }
            for c1 := range userPurchases[user] {
                for c2 := range userPurchases[friend] {
                    if c1 != c2 {
                        pair := [2]int{c1, c2}
                        if c1 > c2 {
                            pair = [2]int{c2, c1}
                        }
                        categoryPairs[pair] = true
                    }
                }
            }
        }
    }

    var result [][]int
    for pair := range categoryPairs {
        result = append(result, []int{pair[0], pair[1]})
    }

    sort.Slice(result, func(i, j int) bool {
        if result[i][0] == result[j][0] {
            return result[i][1] < result[j][1]
        }
        return result[i][0] < result[j][0]
    })

    return result
}