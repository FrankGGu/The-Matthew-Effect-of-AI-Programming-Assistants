class Solution {
    public int maxCost(String s, String chars, int[] vals) {
        int[] cost = new int[26];
        for (int i = 0; i < 26; i++) {
            cost[i] = i - 25;
        }

        for (int i = 0; i < chars.length(); i++) {
            cost[chars.charAt(i) - 'a'] = vals[i];
        }

        int maxSoFar = 0;
        int currentMax = 0;

        for (int i = 0; i < s.length(); i++) {
            currentMax += cost[s.charAt(i) - 'a'];
            if (currentMax < 0) {
                currentMax = 0;
            }
            maxSoFar = Math.max(maxSoFar, currentMax);
        }

        return maxSoFar;
    }
}