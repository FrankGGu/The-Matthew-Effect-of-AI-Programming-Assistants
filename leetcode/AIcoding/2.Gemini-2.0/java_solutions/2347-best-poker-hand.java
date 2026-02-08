class Solution {
    public String bestHand(int[] ranks, char[] suits) {
        boolean flush = true;
        for (int i = 1; i < 5; i++) {
            if (suits[i] != suits[0]) {
                flush = false;
                break;
            }
        }

        if (flush) {
            return "Flush";
        }

        int[] rankCounts = new int[14];
        for (int rank : ranks) {
            rankCounts[rank]++;
        }

        boolean threeOfAKind = false;
        boolean pair = false;
        for (int count : rankCounts) {
            if (count >= 5) return "Three of a Kind";
            if (count >= 4) return "Four of a Kind";
            if (count >= 3) {
                threeOfAKind = true;
            }
            if (count >= 2) {
                pair = true;
            }
        }

        if (threeOfAKind) {
            return "Three of a Kind";
        }

        if (pair) {
            return "Pair";
        }

        return "High Card";
    }
}