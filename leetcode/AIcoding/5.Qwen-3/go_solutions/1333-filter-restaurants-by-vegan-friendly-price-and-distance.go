package main

func filterRestaurants(restaurants [][]int, veganFriendly int, maxPrice int, maxDistance int) [][]int {
    var result [][]int
    for _, r := range restaurants {
        if veganFriendly == 1 && r[2] != 1 {
            continue
        }
        if r[3] > maxPrice || r[4] > maxDistance {
            continue
        }
        result = append(result, r)
    }
    sort.Slice(result, func(i, j int) bool {
        if result[i][1] != result[j][1] {
            return result[i][1] > result[j][1]
        }
        return result[i][0] > result[j][0]
    })
    return result
}