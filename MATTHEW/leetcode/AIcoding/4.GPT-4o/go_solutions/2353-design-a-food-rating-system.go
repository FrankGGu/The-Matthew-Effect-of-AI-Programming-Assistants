type FoodRatings struct {
    foodRatings map[string]int
    cuisineMap  map[string]map[int]string
    ratingMap   map[string]string
    maxRatings  []int
}

func Constructor(foods []string, ratings []int) FoodRatings {
    fr := FoodRatings{
        foodRatings: make(map[string]int),
        cuisineMap:  make(map[string]map[int]string),
        ratingMap:   make(map[string]string),
        maxRatings:  []int{},
    }

    for i, food := range foods {
        fr.foodRatings[food] = ratings[i]
        fr.ratingMap[food] = food

        if _, exists := fr.cuisineMap[food]; !exists {
            fr.cuisineMap[food] = make(map[int]string)
        }
        fr.cuisineMap[food][ratings[i]] = food
        fr.maxRatings = append(fr.maxRatings, ratings[i])
    }

    return fr
}

func (this *FoodRatings) ChangeRating(food string, newRating int) {
    oldRating := this.foodRatings[food]
    this.foodRatings[food] = newRating

    delete(this.cuisineMap[food][oldRating], food)
    this.cuisineMap[food][newRating] = food
}

func (this *FoodRatings) HighestRated(cuisine string) string {
    maxRating := -1
    var highestRatedFood string

    for rating, food := range this.cuisineMap[cuisine] {
        if rating > maxRating {
            maxRating = rating
            highestRatedFood = food
        }
    }

    return highestRatedFood
}