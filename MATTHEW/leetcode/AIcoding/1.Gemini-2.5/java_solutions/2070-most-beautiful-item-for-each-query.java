import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int[] mostBeautifulItem(int[][] items, int[] queries) {
        Arrays.sort(items, (a, b) -> a[0] - b[0]);

        int[][] augmentedQueries = new int[queries.length][2];
        for (int i = 0; i < queries.length; i++) {
            augmentedQueries[i][0] = queries[i];
            augmentedQueries[i][1] = i;
        }

        Arrays.sort(augmentedQueries, (a, b) -> a[0] - b[0]);

        int[] result = new int[queries.length];
        int itemPointer = 0;
        int maxBeautySoFar = 0;

        for (int i = 0; i < augmentedQueries.length; i++) {
            int currentQueryPrice = augmentedQueries[i][0];
            int originalQueryIndex = augmentedQueries[i][1];

            while (itemPointer < items.length && items[itemPointer][0] <= currentQueryPrice) {
                maxBeautySoFar = Math.max(maxBeautySoFar, items[itemPointer][1]);
                itemPointer++;
            }
            result[originalQueryIndex] = maxBeautySoFar;
        }

        return result;
    }
}