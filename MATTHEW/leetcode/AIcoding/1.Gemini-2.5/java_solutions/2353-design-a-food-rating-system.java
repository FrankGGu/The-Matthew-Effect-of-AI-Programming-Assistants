import java.util.HashMap;
import java.util.Map;
import java.util.PriorityQueue;

class FoodRatings {

    private Map<String, Integer> foodToRating;
    private Map<String, String> foodToCuisine;
    private Map<String, PriorityQueue<FoodData>> cuisineToFoods;

    private static class FoodData {
        String name;
        int rating;

        FoodData(String name, int rating) {
            this.name = name;
            this.rating = rating;
        }
    }

    public FoodRatings(String[] foods, String[] cuisines, int[] ratings) {
        foodToRating = new HashMap<>();
        foodToCuisine = new HashMap<>();
        cuisineToFoods = new HashMap<>();

        for (int i = 0; i < foods.length; i++) {
            String food = foods[i];
            String cuisine = cuisines[i];
            int rating = ratings[i];

            foodToRating.put(food, rating);
            foodToCuisine.put(food, cuisine);

            cuisineToFoods
                .computeIfAbsent(cuisine, k -> new PriorityQueue<>((a, b) -> {
                    if (a.rating != b.rating) {
                        return b.rating - a.rating;
                    }
                    return a.name.compareTo(b.name);
                }))
                .add(new FoodData(food, rating));
        }
    }

    public void changeRating(String food, int newRating) {
        foodToRating.put(food, newRating);
        String cuisine = foodToCuisine.get(food);
        cuisineToFoods.get(cuisine).add(new FoodData(food, newRating));
    }

    public String highestRated(String cuisine) {
        PriorityQueue<FoodData> pq = cuisineToFoods.get(cuisine);

        while (!pq.isEmpty()) {
            FoodData top = pq.peek();
            if (top.rating == foodToRating.get(top.name)) {
                return top.name;
            } else {
                pq.poll();
            }
        }
        return null;
    }
}