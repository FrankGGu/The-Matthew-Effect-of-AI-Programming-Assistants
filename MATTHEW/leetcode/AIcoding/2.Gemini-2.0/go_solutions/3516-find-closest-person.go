import (
	"sort"
)

func findClosest(customers []string, restaurants []string, location string) string {
	minDist := 100001.0
	closestRestaurant := ""
	for _, restaurant := range restaurants {
		dist := calculateDistance(location, restaurant)
		if dist < minDist {
			minDist = dist
			closestRestaurant = restaurant
		}
	}
	return closestRestaurant
}

func calculateDistance(location string, restaurant string) float64 {
	locationRunes := []rune(location)
	restaurantRunes := []rune(restaurant)
	x1 := int(locationRunes[0])
	y1 := int(locationRunes[1])
	x2 := int(restaurantRunes[0])
	y2 := int(restaurantRunes[1])
	return float64((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2))
}

func suggestRestaurants(restaurants []string, k int) []string {
	sort.Strings(restaurants)
	if len(restaurants) < k {
		return restaurants
	}
	return restaurants[:k]
}