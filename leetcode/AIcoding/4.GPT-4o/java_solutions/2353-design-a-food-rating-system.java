import java.util.*;

class FoodRatings {
    private Map<String, Integer> foodRatings;
    private Map<String, TreeSet<String>> cuisineMap;
    private Map<String, String> foodCuisine;

    public FoodRatings(String[] foods, String[] cuisines, int[] ratings) {
        foodRatings = new HashMap<>();
        cuisineMap = new HashMap<>();
        foodCuisine = new HashMap<>();

        for (int i = 0; i < foods.length; i++) {
            foodRatings.put(foods[i], ratings[i]);
            foodCuisine.put(foods[i], cuisines[i]);
            cuisineMap.putIfAbsent(cuisines[i], new TreeSet<>((a, b) -> {
                int cmp = Integer.compare(foodRatings.get(b), foodRatings.get(a));
                return cmp != 0 ? cmp : a.compareTo(b);
            }));
            cuisineMap.get(cuisines[i]).add(foods[i]);
        }
    }

    public void changeRating(String food, int newRating) {
        String cuisine = foodCuisine.get(food);
        cuisineMap.get(cuisine).remove(food);
        foodRatings.put(food, newRating);
        cuisineMap.get(cuisine).add(food);
    }

    public String highestRated(String cuisine) {
        return cuisineMap.get(cuisine).first();
    }
}