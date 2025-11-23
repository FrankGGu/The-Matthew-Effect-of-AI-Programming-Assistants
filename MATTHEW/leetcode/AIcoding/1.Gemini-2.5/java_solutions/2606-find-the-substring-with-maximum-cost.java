import java.util.HashMap;
import java.util.Map;

class Solution {
    public int maximumCostSubstring(String s, String chars, int[] vals) {
        Map<Character, Integer> costMap = new HashMap<>();
        for (int i = 0; i < chars.length(); i++) {
            costMap.put(chars.charAt(i), vals[i]);
        }

        int maxCost = 0;
        int currentSum = 0;

        for (char c : s.toCharArray()) {
            int charCost;
            if (costMap.containsKey(c)) {
                charCost = costMap.get(c);
            } else {
                charCost = c - 'a' + 1;
            }

            currentSum += charCost;

            if (currentSum < 0) {
                currentSum = 0;
            }

            maxCost = Math.max(maxCost, currentSum);
        }

        return maxCost;
    }
}