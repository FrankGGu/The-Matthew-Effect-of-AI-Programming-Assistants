import java.util.HashMap;
import java.util.Map;

class Solution {
    public int minimumCardPickup(int[] cards) {
        Map<Integer, Integer> lastSeen = new HashMap<>();
        int minLength = Integer.MAX_VALUE;

        for (int i = 0; i < cards.length; i++) {
            int card = cards[i];
            if (lastSeen.containsKey(card)) {
                minLength = Math.min(minLength, i - lastSeen.get(card) + 1);
            }
            lastSeen.put(card, i);
        }

        return minLength == Integer.MAX_VALUE ? -1 : minLength;
    }
}