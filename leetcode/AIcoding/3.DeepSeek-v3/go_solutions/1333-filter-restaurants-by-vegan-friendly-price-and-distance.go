func filterRestaurants(restaurants [][]int, veganFriendly int, maxPrice int, maxDistance int) []int {
    filtered := [][]int{}
    for _, r := range restaurants {
        if (veganFriendly == 0 || r[2] == veganFriendly) && r[3] <= maxPrice && r[4] <= maxDistance {
            filtered = append(filtered, r)
        }
    }

    sort.Slice(filtered, func(i, j int) bool {
        if filtered[i][1] == filtered[j][1] {
            return filtered[i][0] > filtered[j][0]
        }
        return filtered[i][1] > filtered[j][1]
    })

    res := []int{}
    for _, r := range filtered {
        res = append(res, r[0])
    }
    return res
}