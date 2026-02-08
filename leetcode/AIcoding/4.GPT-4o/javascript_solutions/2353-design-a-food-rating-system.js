class FoodRatings {
    constructor(foods, cuisines) {
        this.foodRatings = new Map();
        this.cuisineMap = new Map();
        this.cuisineRatings = new Map();

        for (let i = 0; i < foods.length; i++) {
            this.foodRatings.set(foods[i], { rating: 0, cuisine: cuisines[i] });
            if (!this.cuisineMap.has(cuisines[i])) {
                this.cuisineMap.set(cuisines[i], new Set());
                this.cuisineRatings.set(cuisines[i], []);
            }
            this.cuisineMap.get(cuisines[i]).add(foods[i]);
            this.cuisineRatings.get(cuisines[i]).push({ food: foods[i], rating: 0 });
        }
    }

    changeRating(food, newRating) {
        const { cuisine } = this.foodRatings.get(food);
        const oldRating = this.foodRatings.get(food).rating;
        this.foodRatings.get(food).rating = newRating;

        this.updateCuisineRatings(cuisine, food, oldRating, newRating);
    }

    updateCuisineRatings(cuisine, food, oldRating, newRating) {
        const index = this.cuisineRatings.get(cuisine).findIndex(item => item.food === food);
        this.cuisineRatings.get(cuisine)[index].rating = newRating;

        this.cuisineRatings.get(cuisine).sort((a, b) => b.rating - a.rating);
    }

    highestRated(food) {
        return food;
    }
}