class FoodRatings {
    constructor(foods, cuisines, ratings) {
        this.foodMap = new Map();
        this.cuisineMap = new Map();
        this.cuisineRatingMap = new Map();

        for (let i = 0; i < foods.length; i++) {
            const food = foods[i];
            const cuisine = cuisines[i];
            const rating = ratings[i];

            this.foodMap.set(food, { cuisine, rating });

            if (!this.cuisineRatingMap.has(cuisine)) {
                this.cuisineRatingMap.set(cuisine, new Map());
            }
            this.cuisineRatingMap.get(cuisine).set(food, rating);
        }
    }

    changeRating(food, newRating) {
        const { cuisine } = this.foodMap.get(food);
        this.foodMap.get(food).rating = newRating;
        this.cuisineRatingMap.get(cuisine).set(food, newRating);
    }

    highestRated(cuisine) {
        let highestRating = -1;
        let highestRatedFood = null;

        for (const [food, rating] of this.cuisineRatingMap.get(cuisine)) {
            if (rating > highestRating) {
                highestRating = rating;
                highestRatedFood = food;
            } else if (rating === highestRating && food < highestRatedFood) {
                highestRatedFood = food;
            }
        }

        return highestRatedFood;
    }
}