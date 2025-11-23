class FoodRatings {
    constructor(foods, cuisines, ratings) {
        this.foodMap = {};
        this.cuisineMap = {};

        for (let i = 0; i < foods.length; i++) {
            const food = foods[i];
            const cuisine = cuisines[i];
            const rating = ratings[i];

            this.foodMap[food] = { cuisine, rating };

            if (!this.cuisineMap[cuisine]) {
                this.cuisineMap[cuisine] = new MaxPriorityQueue({
                    priority: (item) => item.rating,
                    compare: (a, b) => {
                        if (a.rating === b.rating) {
                            return a.food.localeCompare(b.food);
                        }
                        return b.rating - a.rating;
                    }
                });
            }

            this.cuisineMap[cuisine].enqueue({ food, rating });
        }
    }

    changeRating(food, newRating) {
        const { cuisine, rating } = this.foodMap[food];
        this.foodMap[food].rating = newRating;
        this.cuisineMap[cuisine].enqueue({ food, rating: newRating });
    }

    highestRated(cuisine) {
        while (true) {
            const { element } = this.cuisineMap[cuisine].front();
            if (this.foodMap[element.food].rating === element.rating) {
                return element.food;
            }
            this.cuisineMap[cuisine].dequeue();
        }
    }
}