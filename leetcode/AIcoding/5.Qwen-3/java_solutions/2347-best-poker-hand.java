public class Solution {

import java.util.*;

public class Solution {
    public String bestHand(int[] ranks, char[] suits) {
        Map<Integer, Integer> rankCount = new HashMap<>();
        for (int rank : ranks) {
            rankCount.put(rank, rankCount.getOrDefault(rank, 0) + 1);
        }

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

        int maxCount = 0;
        for (int count : rankCount.values()) {
            maxCount = Math.max(maxCount, count);
        }

        if (maxCount >= 4) {
            return "Four of a Kind";
        } else if (maxCount == 3) {
            return "Three of a Kind";
        } else if (maxCount == 2) {
            return "Pair";
        } else {
            return "High Card";
        }
    }
}
}