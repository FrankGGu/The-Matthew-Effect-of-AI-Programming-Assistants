import java.util.TreeMap;

class Solution {
    public boolean isNStraightHand(int[] hand, int groupSize) {
        if (hand.length % groupSize != 0) {
            return false;
        }

        TreeMap<Integer, Integer> counts = new TreeMap<>();
        for (int card : hand) {
            counts.put(card, counts.getOrDefault(card, 0) + 1);
        }

        while (!counts.isEmpty()) {
            int startCard = counts.firstKey();
            for (int i = 0; i < groupSize; i++) {
                int currentCard = startCard + i;
                if (!counts.containsKey(currentCard) || counts.get(currentCard) == 0) {
                    return false;
                }
                counts.put(currentCard, counts.get(currentCard) - 1);
                if (counts.get(currentCard) == 0) {
                    counts.remove(currentCard);
                }
            }
        }

        return true;
    }
}