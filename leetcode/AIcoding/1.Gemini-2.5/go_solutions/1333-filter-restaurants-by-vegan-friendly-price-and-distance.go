import (
	"sort"
)

func filterRestaurants(restaurants [][]int, veganFriendly int, maxPrice int, maxDistance int) []int {
	filtered := make([][]int, 0)

	for _, r := range restaurants {
		if veganFriendly == 1 && r[2] == 0 {
			continue
		}
		if r[3] > maxPrice {
			continue
		}
		if r[4] > maxDistance {
			continue
		}
		filtered = append(filtered, []int{r[1], r[0]}) // Store [rating, id]
	}

	sort.Slice(filtered, func(i, j int) bool {
		if filtered[i][0] != filtered[j][0] {
			return filtered[i][0] > filtered[j][0]
		}
		return filtered[i][1] > filtered[j][1]
	})

	result := make([]int, len(filtered))
	for i, r := range filtered {
		result[i] = r[1]
	}

	return result
}