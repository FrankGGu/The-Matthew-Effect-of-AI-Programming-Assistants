import "sort"

func filterRestaurants(restaurants [][]int, veganFriendly int, maxPrice int, maxDistance int) []int {
	filtered := [][]int{}
	for _, r := range restaurants {
		if r[3] <= maxPrice && r[4] <= maxDistance {
			if veganFriendly == 1 && r[2] == 0 {
				continue
			}
			filtered = append(filtered, r)
		}
	}

	sort.Slice(filtered, func(i, j int) bool {
		if filtered[i][1] == filtered[j][1] {
			return filtered[i][0] > filtered[j][0]
		}
		return filtered[i][1] > filtered[j][1]
	})

	result := []int{}
	for _, r := range filtered {
		result = append(result, r[0])
	}

	return result
}