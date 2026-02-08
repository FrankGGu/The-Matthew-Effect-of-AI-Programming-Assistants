import java.util.HashMap;
import java.util.Map;

class Solution {
    public int rearrangeCharacters(String s, String target) {
        Map<Character, Integer> sMap = new HashMap<>();
        Map<Character, Integer> targetMap = new HashMap<>();

        for (char c : s.toCharArray()) {
            sMap.put(c, sMap.getOrDefault(c, 0) + 1);
        }

        for (char c : target.toCharArray()) {
            targetMap.put(c, targetMap.getOrDefault(c, 0) + 1);
        }

        int count = Integer.MAX_VALUE;
        for (Map.Entry<Character, Integer> entry : targetMap.entrySet()) {
            char c = entry.getKey();
            int targetCount = entry.getValue();

            if (!sMap.containsKey(c)) {
                return 0;
            }

            int sCount = sMap.get(c);
            count = Math.min(count, sCount / targetCount);
        }

        return count;
    }
}