class Solution {
    public String bestHand(int[] ranks, char[] suits) {
        boolean isFlush = true;
        char firstSuit = suits[0];
        for (char suit : suits) {
            if (suit != firstSuit) {
                isFlush = false;
                break;
            }
        }
        if (isFlush) {
            return "Flush";
        }

        int[] rankCount = new int[14];
        for (int rank : ranks) {
            rankCount[rank]++;
        }

        boolean hasThree = false;
        boolean hasPair = false;
        for (int count : rankCount) {
            if (count >= 3) {
                hasThree = true;
                break;
            } else if (count == 2) {
                hasPair = true;
            }
        }

        if (hasThree) {
            return "Three of a Kind";
        } else if (hasPair) {
            return "Pair";
        } else {
            return "High Card";
        }
    }
}