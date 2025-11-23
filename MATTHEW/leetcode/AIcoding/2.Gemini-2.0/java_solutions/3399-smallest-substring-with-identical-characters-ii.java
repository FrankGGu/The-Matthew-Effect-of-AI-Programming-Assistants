import java.util.HashMap;
import java.util.Map;

class Solution {
    public int smallestSubstring(String s) {
        int n = s.length();
        int minLen = Integer.MAX_VALUE;
        Map<Character, Integer> counts = new HashMap<>();

        for (int i = 0; i < n; i++) {
            counts.clear();
            for (int j = i; j < n; j++) {
                char c = s.charAt(j);
                counts.put(c, counts.getOrDefault(c, 0) + 1);

                boolean allSame = true;
                if (counts.size() > 0) {
                    int firstCount = counts.values().iterator().next();
                    for (int count : counts.values()) {
                        if (count != firstCount) {
                            allSame = false;
                            break;
                        }
                    }
                } else {
                    allSame = false;
                }

                if (allSame && counts.size() > 0) {
                    minLen = Math.min(minLen, j - i + 1);
                }
            }
        }

        return minLen == Integer.MAX_VALUE ? -1 : minLen;
    }
}