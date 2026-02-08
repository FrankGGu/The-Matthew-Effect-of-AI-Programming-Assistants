import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

class Solution {
    public List<Integer> filterRestaurants(int[][] restaurants, int veganFriendly, int maxPrice, int maxDistance) {
        List<int[]> filtered = new ArrayList<>();

        for (int[] restaurant : restaurants) {
            // restaurant[0] = id
            // restaurant[1] = rating
            // restaurant[2] = veganFriendly (0 or 1)
            // restaurant[3] = price
            // restaurant[4] = distance

            // Apply filtering conditions
            boolean passesVeganFriendly = (veganFriendly == 0 || restaurant[2] == 1);
            boolean passesPrice = (restaurant[3] <= maxPrice);
            boolean passesDistance = (restaurant[4] <= maxDistance);

            if (passesVeganFriendly && passesPrice && passesDistance) {
                filtered.add(restaurant);
            }
        }

        // Sort the filtered list based on rating (descending) then id (descending)
        Collections.sort(filtered, (r1, r2) -> {
            // Compare ratings (index 1)
            if (r1[1] != r2[1]) {
                return r2[1] - r1[1]; // Descending order for rating
            } else {
                // If ratings are equal, compare IDs (index 0)
                return r2[0] - r1[0]; // Descending order for ID
            }
        });

        // Extract IDs from the sorted list
        List<Integer> resultIds = new ArrayList<>();
        for (int[] restaurant : filtered) {
            resultIds.add(restaurant[0]);
        }

        return resultIds;
    }
}