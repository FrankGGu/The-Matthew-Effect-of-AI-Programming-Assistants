import java.util.HashMap;
import java.util.Map;

class Solution {
    public int numEquivDominoPairs(int[][] dominoes) {
        Map<Integer, Integer> counts = new HashMap<>();
        int totalPairs = 0;

        for (int[] domino : dominoes) {
            int d1 = domino[0];
            int d2 = domino[1];

            // Normalize the domino to ensure d1 <= d2
            if (d1 > d2) {
                int temp = d1;
                d1 = d2;
                d2 = temp;
            }

            // Create a unique key for the normalized domino
            // Since 1 <= d1, d2 <= 9, d1 * 10 + d2 will be unique for each pair
            int key = d1 * 10 + d2;

            // Get current count of this domino type
            int currentCount = counts.getOrDefault(key, 0);

            // If there are 'currentCount' dominoes of this type already seen,
            // then the new domino forms 'currentCount' pairs with them.
            totalPairs += currentCount;

            // Increment the count for this domino type
            counts.put(key, currentCount + 1);
        }

        return totalPairs;
    }
}