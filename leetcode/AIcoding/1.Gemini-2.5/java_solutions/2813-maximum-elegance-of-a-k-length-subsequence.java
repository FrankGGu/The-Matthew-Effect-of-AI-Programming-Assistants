import java.util.Arrays;
import java.util.HashSet;
import java.util.PriorityQueue;
import java.util.Set;

class Solution {
    public long findMaximumElegance(int[][] items, int k) {
        Arrays.sort(items, (a, b) -> b[0] - a[0]);

        long currentProfit = 0;
        Set<Integer> distinctCategories = new HashSet<>();
        PriorityQueue<Integer> duplicateProfits = new PriorityQueue<>(); // Min-heap to store profits of items that are part of duplicate categories

        // 1. Select the initial k items with the highest profits
        for (int i = 0; i < k; i++) {
            int profit = items[i][0];
            int category = items[i][1];

            currentProfit += profit;
            if (distinctCategories.contains(category)) {
                duplicateProfits.offer(profit);
            } else {
                distinctCategories.add(category);
            }
        }

        long maxElegance = currentProfit + (long) distinctCategories.size() * distinctCategories.size();

        // 2. Iterate through the remaining items (from k to n-1)
        // Try to swap a duplicate-category item (from duplicateProfits) with a new-category item
        for (int i = k; i < items.length; i++) {
            int profit = items[i][0];
            int category = items[i][1];

            // If the current item's category is already in our selection,
            // adding it won't increase distinct categories. We only want to swap
            // if it increases distinct categories.
            if (distinctCategories.contains(category)) {
                continue;
            }

            // If there are no duplicate-category items to remove, we cannot increase
            // distinct categories by swapping. Since items are sorted by profit descending,
            // further items will only have less profit and won't help.
            if (duplicateProfits.isEmpty()) {
                break;
            }

            // Perform the swap:
            // Remove the smallest profit item from a duplicate category
            int profitToRemove = duplicateProfits.poll();
            currentProfit = currentProfit - profitToRemove + profit;

            // Add the new category
            distinctCategories.add(category);

            // Update max elegance
            maxElegance = Math.max(maxElegance, currentProfit + (long) distinctCategories.size() * distinctCategories.size());
        }

        return maxElegance;
    }
}