import java.util.HashMap;

class Solution {
    public boolean areOccurrencesEqual(String s) {
        HashMap<Character, Integer> countMap = new HashMap<>();
        for (char c : s.toCharArray()) {
            countMap.put(c, countMap.getOrDefault(c, 0) + 1);
        }
        int occurrence = countMap.values().iterator().next();
        for (int val : countMap.values()) {
            if (val != occurrence) {
                return false;
            }
        }
        return true;
    }
}