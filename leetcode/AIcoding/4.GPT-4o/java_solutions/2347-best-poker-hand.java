import java.util.HashMap;

class Solution {
    public String bestHand(int[] ranks) {
        HashMap<Integer, Integer> count = new HashMap<>();
        int maxCount = 0;

        for (int rank : ranks) {
            count.put(rank, count.getOrDefault(rank, 0) + 1);
            maxCount = Math.max(maxCount, count.get(rank));
        }

        if (maxCount >= 3) {
            return "Three of a Kind";
        } else if (maxCount == 2) {
            return "Pair";
        } else {
            return "High Card";
        }
    }
}