class Solution {
    public long minimumMoney(int[][] transactions) {
        long totalMoney = 0;
        long maxDeficit = 0;

        for (int[] transaction : transactions) {
            int cost = transaction[0];
            int gain = transaction[1];
            totalMoney += Math.max(0, cost - gain);
            maxDeficit = Math.max(maxDeficit, cost - gain);
        }

        return totalMoney + maxDeficit;
    }
}