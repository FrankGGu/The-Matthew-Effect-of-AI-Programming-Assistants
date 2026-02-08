package main

type FoodRatingSystem struct {
	ratingMap map[string]int
	cuisineMap map[string][]string
}

func Constructor() FoodRatingSystem {
	return FoodRatingSystem{
		ratingMap: make(map[string]int),
		cuisineMap: make(map[string][]string),
	}
}

func (this *FoodRatingSystem) ChangeRating(food string, newRating int) {
	this.ratingMap[food] = newRating
}

func (this *FoodRatingSystem) HighestRated(cuisine string) string {
	foods := this.cuisineMap[cuisine]
	maxRating := -1
	var bestFood string
	for _, food := range foods {
		if this.ratingMap[food] > maxRating {
			maxRating = this.ratingMap[food]
			bestFood = food
		} else if this.ratingMap[food] == maxRating && food < bestFood {
			bestFood = food
		}
	}
	return bestFood
}

func (this *FoodRatingSystem) AddFood(food string, cuisine string, rating int) {
	this.ratingMap[food] = rating
	this.cuisineMap[cuisine] = append(this.cuisineMap[cuisine], food)
}