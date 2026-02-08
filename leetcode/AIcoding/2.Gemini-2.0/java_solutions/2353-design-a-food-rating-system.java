import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.PriorityQueue;
import java.util.Set;

class FoodRatings {

    private Map<String, String> foodToCuisine;
    private Map<String, Integer> foodToRating;
    private Map<String, PriorityQueue<Food>> cuisineToFoods;

    public FoodRatings(String[] foods, String[] cuisines, int[] ratings) {
        foodToCuisine = new HashMap<>();
        foodToRating = new HashMap<>();
        cuisineToFoods = new HashMap<>();

        for (int i = 0; i < foods.length; i++) {
            foodToCuisine.put(foods[i], cuisines[i]);
            foodToRating.put(foods[i], ratings[i]);

            String cuisine = cuisines[i];
            if (!cuisineToFoods.containsKey(cuisine)) {
                cuisineToFoods.put(cuisine, new PriorityQueue<>((a, b) -> {
                    if (b.rating != a.rating) {
                        return b.rating - a.rating;
                    } else {
                        return a.name.compareTo(b.name);
                    }
                }));
            }
            cuisineToFoods.get(cuisine).offer(new Food(foods[i], ratings[i]));
        }
    }

    public void changeRating(String food, int newRating) {
        foodToRating.put(food, newRating);
        String cuisine = foodToCuisine.get(food);
        cuisineToFoods.get(cuisine).offer(new Food(food, newRating));
    }

    public String highestRated(String cuisine) {
        PriorityQueue<Food> pq = cuisineToFoods.get(cuisine);
        Food highestRatedFood = pq.peek();
        while (foodToRating.get(highestRatedFood.name) != highestRatedFood.rating) {
            pq.poll();
            highestRatedFood = pq.peek();
        }
        return highestRatedFood.name;
    }

    private static class Food {
        String name;
        int rating;

        public Food(String name, int rating) {
            this.name = name;
            this.rating = rating;
        }
    }
}