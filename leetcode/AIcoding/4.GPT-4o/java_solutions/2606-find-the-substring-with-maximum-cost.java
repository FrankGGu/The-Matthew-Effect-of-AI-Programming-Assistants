class Solution {
    public int maximumCostSubstring(String s, String chars, int[] vals) {
        int[] cost = new int[26];
        for (int i = 0; i < chars.length(); i++) {
            cost[chars.charAt(i) - 'a'] = vals[i];
        }

        int maxCost = 0, currentCost = 0;

        for (char ch : s.toCharArray()) {
            currentCost += cost[ch - 'a'];
            if (currentCost < 0) {
                currentCost = 0;
            }
            maxCost = Math.max(maxCost, currentCost);
        }

        return maxCost;
    }
}