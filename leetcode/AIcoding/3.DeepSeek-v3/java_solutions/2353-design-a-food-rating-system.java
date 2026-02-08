import java.util.*;

class FoodRatings {
    class Food {
        String name;
        String cuisine;
        int rating;

        public Food(String name, String cuisine, int rating) {
            this.name = name;
            this.cuisine = cuisine;
            this.rating = rating;
        }
    }

    private Map<String, Food> foodMap;
    private Map<String, TreeSet<Food>> cuisineMap;

    public FoodRatings(String[] foods, String[] cuisines, int[] ratings) {
        foodMap = new HashMap<>();
        cuisineMap = new HashMap<>();

        for (int i = 0; i < foods.length; i++) {
            String foodName = foods[i];
            String cuisine = cuisines[i];
            int rating = ratings[i];

            Food food = new Food(foodName, cuisine, rating);
            foodMap.put(foodName, food);

            cuisineMap.computeIfAbsent(cuisine, k -> new TreeSet<>((a, b) -> {
                if (a.rating != b.rating) {
                    return Integer.compare(b.rating, a.rating);
                } else {
                    return a.name.compareTo(b.name);
                }
            })).add(food);
        }
    }

    public void changeRating(String food, int newRating) {
        Food curr = foodMap.get(food);
        TreeSet<Food> set = cuisineMap.get(curr.cuisine);
        set.remove(curr);
        curr.rating = newRating;
        set.add(curr);
    }

    public String highestRated(String cuisine) {
        return cuisineMap.get(cuisine).first().name;
    }
}