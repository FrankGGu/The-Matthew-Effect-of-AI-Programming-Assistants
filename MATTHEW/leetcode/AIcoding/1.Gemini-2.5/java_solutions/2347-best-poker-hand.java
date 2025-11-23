import java.util.HashMap;
import java.util.Map;

class Solution {
    public String bestHand(int[] ranks, char[] suits) {
        // Check for Flush
        boolean isFlush = true;
        for (int i = 1; i < suits.length; i++) {
            if (suits[i] != suits[0]) {
                isFlush = false;
                break;
            }
        }
        if (isFlush) {
            return "Flush";
        }

        // Check for Three of a Kind, Pair, or High Card based on ranks
        Map<Integer, Integer> rankCounts = new HashMap<>();
        for (int rank : ranks) {
            rankCounts.put(rank, rankCounts.getOrDefault(rank, 0) + 1);
        }

        int maxFreq = 0;
        for (int count : rankCounts.values()) {
            maxFreq = Math.max(maxFreq, count);
        }

        if (maxFreq >= 3) {
            return "Three of a Kind";
        } else if (maxFreq == 2) {
            return "Pair";
        } else { // maxFreq must be 1, meaning all ranks are distinct
            return "High Card";
        }
    }
}