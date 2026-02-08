import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public boolean isNStraightHand(int[] hand, int groupSize) {
        if (hand.length % groupSize != 0) {
            return false;
        }

        Arrays.sort(hand);
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int card : hand) {
            countMap.put(card, countMap.getOrDefault(card, 0) + 1);
        }

        for (int card : hand) {
            if (countMap.getOrDefault(card, 0) > 0) {
                countMap.put(card, countMap.get(card) - 1);
                for (int i = 1; i < groupSize; i++) {
                    int nextCard = card + i;
                    if (countMap.getOrDefault(nextCard, 0) > 0) {
                        countMap.put(nextCard, countMap.get(nextCard) - 1);
                    } else {
                        return false;
                    }
                }
            }
        }

        return true;
    }
}