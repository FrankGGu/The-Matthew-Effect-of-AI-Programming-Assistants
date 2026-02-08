class Solution {
    public int minimumCost(String s) {
        int[] cost = new int[26];
        for (char c : s.toCharArray()) {
            cost[c - 'a']++;
        }
        int minCost = Integer.MAX_VALUE;

        for (int cnt : cost) {
            if (cnt > 0) {
                minCost = Math.min(minCost, cnt);
            }
        }

        return minCost == Integer.MAX_VALUE ? 0 : minCost;
    }
}