import java.util.ArrayList;
import java.util.List;

class Restaurant {
    int id;
    String name;
    int price;
    int distance;
    boolean veganFriendly;

    Restaurant(int id, String name, int price, int distance, boolean veganFriendly) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.distance = distance;
        this.veganFriendly = veganFriendly;
    }
}

class Solution {
    public List<List<Integer>> filterRestaurants(List<Restaurant> restaurants, int veganFriendly, int maxPrice, int maxDistance) {
        List<List<Integer>> result = new ArrayList<>();
        for (Restaurant restaurant : restaurants) {
            if ((veganFriendly == 0 || (veganFriendly == 1 && restaurant.veganFriendly)) &&
                restaurant.price <= maxPrice && restaurant.distance <= maxDistance) {
                result.add(List.of(restaurant.id, restaurant.name));
            }
        }
        result.sort((a, b) -> {
            if (!a.get(1).equals(b.get(1))) {
                return a.get(1).compareTo(b.get(1));
            }
            return Integer.compare(b.get(0), a.get(0));
        });
        return result;
    }
}