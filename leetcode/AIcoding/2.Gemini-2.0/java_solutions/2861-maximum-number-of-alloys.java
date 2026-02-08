class Solution {
    public int maxNumberOfAlloys(int n, int k, int budget, List<List<Integer>> composition, List<Integer> stock, List<Integer> cost) {
        int low = 0, high = 100000000;
        int ans = 0;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            boolean possible = false;
            for (int i = 0; i < k; i++) {
                long moneyNeeded = 0;
                for (int j = 0; j < n; j++) {
                    long needed = (long) composition.get(i).get(j) * mid;
                    long diff = needed - stock.get(j);
                    if (diff > 0) {
                        moneyNeeded += diff * cost.get(j);
                    }
                }
                if (moneyNeeded <= budget) {
                    possible = true;
                    break;
                }
            }
            if (possible) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return ans;
    }
}