type Restaurant struct {
    Id            int
    Name          string
    VeganFriendly  int
    Price         int
    Distance      int
}

func filterRestaurants(restaurants [][]int, veganFriendly int, maxPrice int, maxDistance int) [][]int {
    var res [][]int
    for _, restaurant := range restaurants {
        if (veganFriendly == 0 || restaurant[2] == 1) && restaurant[3] <= maxPrice && restaurant[4] <= maxDistance {
            res = append(res, []int{restaurant[0], restaurant[1], restaurant[2], restaurant[3], restaurant[4]})
        }
    }
    sort.Slice(res, func(i, j int) bool {
        if res[i][1] == res[j][1] {
            return res[i][0] > res[j][0]
        }
        return res[i][1] > res[j][1]
    })
    return res
}