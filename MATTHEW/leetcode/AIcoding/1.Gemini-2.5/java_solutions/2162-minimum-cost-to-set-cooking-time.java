class Solution {
    public int minCostSetTime(int targetSeconds, int startAt, int moveCost, int pushCost) {
        long minTotalCost = Long.MAX_VALUE;

        // Case 1: Standard MM:SS representation (seconds < 60)
        int m1 = targetSeconds / 60;
        int s1 = targetSeconds % 60;

        if (m1 <= 99) { // MM must be 00-99
            minTotalCost = Math.min(minTotalCost, calculateCost(m1, s1, startAt, moveCost, pushCost));
        }

        // Case 2: Non-standard MM:SS representation (seconds >= 60)
        // This is only possible if m1 > 0, to borrow 1 minute for seconds
        int m2 = m1 - 1;
        int s2 = s1 + 60;

        if (m2 >= 0 && s2 <= 99) { // MM must be 00-99, SS must be 00-99
            minTotalCost = Math.min(minTotalCost, calculateCost(m2, s2, startAt, moveCost, pushCost));
        }

        return (int) minTotalCost;
    }

    private long calculateCost(int minutes, int seconds, int startAt, int moveCost, int pushCost) {
        // Format MM:SS as a 4-digit string (e.g., 1:10 -> "0110", 0:70 -> "0070")
        String s = String.format("%02d%02d", minutes, seconds);

        // Remove leading zeros to get the sequence of digits to push
        // e.g., "0110" -> "110", "0070" -> "70", "0005" -> "5", "0000" -> ""
        s = s.replaceFirst("^0+", "");

        // If s becomes empty (e.g., for 00:00), it means pushing a single '0'
        if (s.isEmpty()) {
            s = "0";
        }

        long currentCost = 0;
        int currentDigit = startAt;

        for (char c : s.toCharArray()) {
            int digit = c - '0';
            if (digit != currentDigit) {
                currentCost += moveCost;
            }
            currentCost += pushCost;
            currentDigit = digit;
        }
        return currentCost;
    }
}