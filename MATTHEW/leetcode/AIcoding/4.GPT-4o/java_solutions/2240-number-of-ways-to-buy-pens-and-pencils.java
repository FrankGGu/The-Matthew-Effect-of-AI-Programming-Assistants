class Solution {
    public int waysToBuyPensPencils(int totalCoins, int cost1, int cost2) {
        int ways = 0;
        for (int i = 0; i <= totalCoins / cost1; i++) {
            int remainingCoins = totalCoins - i * cost1;
            ways += remainingCoins / cost2 + 1;
        }
        return ways;
    }
}