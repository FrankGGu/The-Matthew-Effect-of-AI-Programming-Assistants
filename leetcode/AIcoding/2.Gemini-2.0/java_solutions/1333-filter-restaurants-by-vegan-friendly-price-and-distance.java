import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public List<Integer> filterRestaurants(int[][] restaurants, int veganFriendly, int maxPrice, int maxDistance) {
        List<int[]> filtered = new ArrayList<>();
        for (int[] restaurant : restaurants) {
            if (restaurant[2] >= veganFriendly && restaurant[3] <= maxPrice && restaurant[4] <= maxDistance) {
                filtered.add(restaurant);
            }
        }

        Collections.sort(filtered, (a, b) -> {
            if (a[1] != b[1]) {
                return b[1] - a[1];
            } else {
                return b[0] - a[0];
            }
        });

        List<Integer> result = new ArrayList<>();
        for (int[] restaurant : filtered) {
            result.add(restaurant[0]);
        }

        return result;
    }
}