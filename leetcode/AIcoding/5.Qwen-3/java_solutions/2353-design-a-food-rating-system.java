public class Solution {

import java.util.*;

class FoodRatings {
    private Map<String, String> cuisineMap;
    private Map<String, PriorityQueue<Food>> foodMap;
    private Map<String, Integer> ratingMap;

    public FoodRatings(String[] foods, String[] cuisines, int[] ratings) {
        cuisineMap = new HashMap<>();
        foodMap = new HashMap<>();
        ratingMap = new HashMap<>();

        for (int i = 0; i < foods.length; i++) {
            String food = foods[i];
            String cuisine = cuisines[i];
            int rating = ratings[i];

            cuisineMap.put(food, cuisine);
            ratingMap.put(food, rating);

            if (!foodMap.containsKey(cuisine)) {
                foodMap.put(cuisine, new PriorityQueue<>((a, b) -> {
                    if (a.rating != b.rating) {
                        return b.rating - a.rating;
                    }
                    return a.name.compareTo(b.name);
                }));
            }

            foodMap.get(cuisine).offer(new Food(food, rating));
        }
    }

    public void changeRating(String food, int newRating) {
        String cuisine = cuisineMap.get(food);
        ratingMap.put(food, newRating);
        foodMap.get(cuisine).offer(new Food(food, newRating));
    }

    public String highestRated(String cuisine) {
        while (!foodMap.get(cuisine).isEmpty()) {
            Food top = foodMap.get(cuisine).peek();
            if (ratingMap.get(top.name) == top.rating) {
                return top.name;
            } else {
                foodMap.get(cuisine).poll();
            }
        }
        return "";
    }

    private static class Food {
        String name;
        int rating;

        Food(String name, int rating) {
            this.name = name;
            this.rating = rating;
        }
    }
}
}