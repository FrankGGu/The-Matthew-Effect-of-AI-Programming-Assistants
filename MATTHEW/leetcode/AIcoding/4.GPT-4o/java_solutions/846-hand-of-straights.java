import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

public class Solution {
    public boolean isNStraightHand(int[] hand, int W) {
        if (hand.length % W != 0) return false;
        Arrays.sort(hand);
        Map<Integer, Integer> count = new HashMap<>();
        for (int card : hand) {
            count.put(card, count.getOrDefault(card, 0) + 1);
        }
        for (int card : hand) {
            if (count.get(card) == 0) continue;
            for (int i = 0; i < W; i++) {
                int nextCard = card + i;
                if (count.getOrDefault(nextCard, 0) <= 0) return false;
                count.put(nextCard, count.get(nextCard) - 1);
            }
            count.put(card, count.get(card) - 1);
        }
        return true;
    }
}