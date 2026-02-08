class Solution {
    public int maximumCostSubstring(String s, String chars, int[] vals) {
        int[] charToValue = new int[26];
        for (int i = 0; i < 26; i++) {
            charToValue[i] = i + 1;
        }
        for (int i = 0; i < chars.length(); i++) {
            char c = chars.charAt(i);
            charToValue[c - 'a'] = vals[i];
        }

        int maxCost = 0;
        int currentCost = 0;
        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            currentCost += charToValue[c - 'a'];
            if (currentCost < 0) {
                currentCost = 0;
            }
            if (currentCost > maxCost) {
                maxCost = currentCost;
            }
        }
        return maxCost;
    }
}