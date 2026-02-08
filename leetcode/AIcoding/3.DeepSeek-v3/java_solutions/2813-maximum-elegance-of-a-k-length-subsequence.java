class Solution {
    public long findMaximumElegance(int[][] items, int k) {
        Arrays.sort(items, (a, b) -> b[0] - a[0]);
        long res = 0;
        long sum = 0;
        Set<Integer> seenCategories = new HashSet<>();
        Stack<Integer> duplicates = new Stack<>();

        for (int i = 0; i < items.length; i++) {
            int profit = items[i][0];
            int category = items[i][1];
            if (i < k) {
                sum += profit;
                if (seenCategories.contains(category)) {
                    duplicates.push(profit);
                } else {
                    seenCategories.add(category);
                }
            } else if (!seenCategories.contains(category) && !duplicates.isEmpty()) {
                seenCategories.add(category);
                sum += profit - duplicates.pop();
            }
            res = Math.max(res, sum + (long) seenCategories.size() * seenCategories.size());
        }
        return res;
    }
}