import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minimumCardPickup(int[] cards) {
        int minLen = Integer.MAX_VALUE;
        Map<Integer, Integer> lastSeen = new HashMap<>();

        for (int i = 0; i < cards.length; i++) {
            if (lastSeen.containsKey(cards[i])) {
                minLen = Math.min(minLen, i - lastSeen.get(cards[i]) + 1);
            }
            lastSeen.put(cards[i], i);
        }

        return minLen == Integer.MAX_VALUE ? -1 : minLen;
    }
}