class Solution {
    public int maxNumberOfAlloys(int n, int k, int budget, List<List<Integer>> composition, List<Integer> stock, List<Integer> cost) {
        int left = 0;
        int right = (int) 2e8;
        int ans = 0;

        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (isPossible(n, k, budget, composition, stock, cost, mid)) {
                ans = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return ans;
    }

    private boolean isPossible(int n, int k, int budget, List<List<Integer>> composition, List<Integer> stock, List<Integer> cost, int target) {
        for (List<Integer> machine : composition) {
            long currentCost = 0;
            for (int i = 0; i < n; i++) {
                long needed = (long) machine.get(i) * target - stock.get(i);
                if (needed > 0) {
                    currentCost += needed * cost.get(i);
                }
                if (currentCost > budget) {
                    break;
                }
            }
            if (currentCost <= budget) {
                return true;
            }
        }
        return false;
    }
}