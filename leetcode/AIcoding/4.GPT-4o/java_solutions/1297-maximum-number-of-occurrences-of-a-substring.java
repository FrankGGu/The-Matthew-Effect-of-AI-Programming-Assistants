import java.util.HashMap;

class Solution {
    public int maxFreq(String s, int maxLetters, int minSize, int maxSize) {
        HashMap<String, Integer> map = new HashMap<>();
        int maxCount = 0;

        for (int size = minSize; size <= maxSize; size++) {
            for (int i = 0; i <= s.length() - size; i++) {
                String substring = s.substring(i, i + size);
                if (isValid(substring, maxLetters)) {
                    map.put(substring, map.getOrDefault(substring, 0) + 1);
                    maxCount = Math.max(maxCount, map.get(substring));
                }
            }
        }
        return maxCount;
    }

    private boolean isValid(String s, int maxLetters) {
        return s.chars().distinct().count() <= maxLetters;
    }
}