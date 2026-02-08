class Solution {
    public int minCostSetTime(int startAt, int moveCost, int pushCost, int targetSeconds) {
        int minCost = Integer.MAX_VALUE;
        for (int minutes = 0; minutes <= 99; minutes++) {
            int seconds = targetSeconds - minutes * 60;
            if (seconds < 0 || seconds > 99) continue;
            String timeStr = String.format("%02d%02d", minutes, seconds);
            timeStr = timeStr.replaceAll("^0+", "");
            if (timeStr.isEmpty()) timeStr = "0";
            minCost = Math.min(minCost, calculateCost(startAt, moveCost, pushCost, timeStr));
        }
        return minCost;
    }

    private int calculateCost(int startAt, int moveCost, int pushCost, String timeStr) {
        int cost = 0;
        int currentPos = startAt;
        for (char c : timeStr.toCharArray()) {
            int digit = c - '0';
            if (digit != currentPos) {
                cost += moveCost;
                currentPos = digit;
            }
            cost += pushCost;
        }
        return cost;
    }
}