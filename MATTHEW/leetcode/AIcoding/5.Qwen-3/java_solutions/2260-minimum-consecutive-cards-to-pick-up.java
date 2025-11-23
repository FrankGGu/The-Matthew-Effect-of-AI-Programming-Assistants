public class Solution {

import java.util.*;

public class Solution {
    public int minimumConsecutiveCardsToPickUp(int[] cards) {
        Map<Integer, Integer> lastPosition = new HashMap<>();
        int minLength = Integer.MAX_VALUE;

        for (int i = 0; i < cards.length; i++) {
            if (lastPosition.containsKey(cards[i])) {
                int prev = lastPosition.get(cards[i]);
                minLength = Math.min(minLength, i - prev + 1);
            }
            lastPosition.put(cards[i], i);
        }

        return minLength == Integer.MAX_VALUE ? -1 : minLength;
    }
}
}